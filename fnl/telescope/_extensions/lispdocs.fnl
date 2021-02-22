(module telescope.__extensions.lispdocs
  {require {telescope :telescope
            finders :telescope.finders
            actions :telescope.actions
            pickers :telescope.pickers
            entry_display :telescope.pickers.entry_display
            state :telescope.state
            util lispdocs.util
            previewers :telescope.previewers
            putils :telescope.previewers.utils
            utils :telescope.utils
            pft :plenary.filetype
            conf :telescope.config
            db :lispdocs.db}})

(defn- make-display [entry]
  (var displayer
    (entry_display.create
      {:separator " "
       :hl_chars {"|" "TelescopeResultsNumber"}
       :items [{:width 30}
               {:remaining true}
               {:remaining true}]}))
  (displayer [[entry.name "TelescopeResultsNumber"]
              [entry.ns "TabLine"]]))   ;; TODO: create highlight for entry.ns

(defn- entry-maker [entry]
  (let [[ns name] (vim.split entry.symbol "/")]
    {:value entry
     :name name
     :ns ns
     :preview entry.preview
     :symbol entry.symbol
     :display make-display
     :ordinal (.. ns " " name)})) ;; TOOD: sort by content

(def- previewer
  (utils.make_default_callable
    (fn [opts]
      (previewers.new_buffer_previewer
        {:keep_last_buf true
         :get_buffer_by_name (fn [_ entry] entry.symbol)
         :define_preview
         (fn [self entry status]
           (when (not= entry.symbol self.state.bufname)
             (vim.api.nvim_buf_set_lines self.state.bufnr 0 -1 false (vim.split entry.preview "||00||"))
             (vim.api.nvim_win_set_option self.state.preview_win "wrap" true)
             (putils.highlighter self.state.bufnr "markdown")))})) {}))

(defn- set-mappings [bufnr]
  (actions.select_default:replace
    (fn [_ cmd]
      (actions.close bufnr)
      (let [last_bufnr (state.get_global_key "last_preview_bufnr")
            run #(vim.cmd (.. $1 " " last_bufnr))]
        (match cmd
          "edit" (run ":buffer")
          "new"  (run ":sbuffer")
          "vnew" (run ":vert sbuffer")
          "tabedit" (run ":tab sb")))))
  true)

(defn- lispdocs-find [opts]
  (var config {:prompt_title "Lispdocs"
               :finder (finders.new_table
                         {:results (opts.tbl:get {:keys ["symbol" "preview"]})
                          :entry_maker entry-maker})
               :previewer (previewer.new opts)
               :sorter (conf.values.generic_sorter opts)
               :attach_mappings set-mappings})
  (: (pickers.new opts config) :find))


(telescope.register_extension
  {:exports
   {:lispdocs #(let [opts (or $1 {})
                     ext (or opts.ext "clj")]  ;; TODO: change to the current file extension
                (tset opts :tbl (or (. db ext) {}))
                (if (and (util.supported ext) (opts.tbl:empty))
                  (opts.tbl:seed (vim.schedule_wrap #(lispdocs-find opts)))
                  (lispdocs-find opts)))}})
