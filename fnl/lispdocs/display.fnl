(module lispdocs.display
  {require {a conjure.aniseed.core
            str conjure.aniseed.string}})

(defn- draw-border [opts style]
  (let [style (or style ["─" "│" "╭" "╮" "╰" "╯"])
        top (.. (a.get style 3)
                (string.rep (a.get style 1) (+ opts.width 2))
                (a.get style 4))
        mid (.. (a.get style 2)
                (string.rep " " (+ opts.width 2))
                (a.get style 2))
        bot (.. (a.get style 5)
                (string.rep (a.get style 1) (+ opts.width 2))
                (a.get style 6))
        lines (let [lines [top]] ;; there must be a better way
                (for [_ 2 (+ opts.height 1) 1]
                  (table.insert lines mid))
                (table.insert lines bot) lines)
        winops (a.merge opts {:row (- opts.row 1)
                              :height (+ opts.height 2)
                              :col (- opts.col 2)
                              :width (+ opts.width 4)})
        bufnr (vim.api.nvim_create_buf false true)
        winid (vim.api.nvim_open_win bufnr true winops)]
    (vim.api.nvim_buf_set_lines bufnr 0 -1 false lines)
    (vim.api.nvim_buf_add_highlight bufnr 0 "ConjureBorder" 1 0 -1)
    winid))

(defn- set-buffer [bufnr content opts]
  ;; Set buffer name
  (let [opts (a.merge
               {:filetype :markdown
                :buflisted false
                :buftype :nofile
                :bufhidden :wipe
                :swapfile false} opts)]
    (each [k v (pairs opts)]
      (vim.api.nvim_buf_set_option bufnr k v))
    (vim.api.nvim_buf_set_lines bufnr 0 0 true content)
    (vim.api.nvim_win_set_cursor 0 [1 0])))

(defn- set-float [opts]
  (let [winops (a.merge {:winblend 5
                         ; :conceallevel 2 ;; FIXME: break conent
                         :winhl "NormalFloat:Normal"}
                        opts.win)
        [primary border] [opts.primary-winid opts.border-winid]
        cursorline (if (a.nil? winops.cursorline) true false)]
    (each [_ win (ipairs [primary border])]
      (each [k v (pairs winops)]
        (when (not= k "cursorline")
          (vim.api.nvim_win_set_option win k v))))

    (if cursorline ;; make sure the the cursorline is present unless its false.
      (vim.api.nvim_win_set_option primary "cursorline" true))

    (->> ["au" "WinClosed,WinLeave"
          (string.format "<buffer=%d>" opts.bufnr) ":bd!" "|" "call"
          (string.format "nvim_win_close(%d," border) "v:true)"]
        (str.join " ")
        vim.cmd)))

(defn- get-float-opts [opts]
  (let [relative (or opts.relative "editor")
        style (or opts.style "minimal")
        fill (or opts.fill 0.8)
        width (math.floor (* vim.o.columns fill))
        height (math.floor (* vim.o.lines fill))
        row (math.floor (- (/ (- vim.o.lines height) 2) 1))
        col (math.floor (/ (- vim.o.columns width) 2))]
    {: relative
     : style
     : width
     : height
     : row
     : col}))

(defn- open-float [opts]
  (let [bufnr  (vim.api.nvim_create_buf false true)
        winops (get-float-opts opts)
        border-winid (draw-border winops opts.border)
        primary-winid (vim.api.nvim_open_win bufnr true winops)]
    (set-float {:win opts.win : primary-winid : border-winid : bufnr})
    (set-buffer bufnr opts.content opts.buf)))

(defn- open-normal [cmd opts]
  (vim.cmd cmd)
  (set-buffer 0 opts.content opts.buf))

(defn open [opts]
  (when (and opts opts.content)
    (match opts.display
      :float  (open-float opts)
      :split  (open-normal "new" opts)
      :vsplit (open-normal "vnew" opts)
      :normal (open-normal "enew" opts))))

