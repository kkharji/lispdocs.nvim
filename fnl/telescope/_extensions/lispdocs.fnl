(module telescope.__extensions.lispdocs
  {require {telescope :telescope
            finders :telescope.finders
            pickers :telescope.pickers
            entry_display :telescope.pickers.entry_display
            previewers :telescope.previewers
            putils :telescope.previewers.utils
            utils :telescope.utils
            pft :plenary.filetype
            conf :telescope.config
            db :lispdocs.db}})

(def- defaulter utils.make_default_callable)

(defn- make-display [entry]
  (var displayer
    (entry_display.create
      {:separator " "
       :hl_chars {"|" "TelescopeResultsNumber"}
       :items [{:width 30}
               {:remaining true}
               {:remaining true}]}))
  ;; create highlight for entry.ns
  (displayer [[entry.name "TelescopeResultsNumber"] [entry.ns "TabLine"] [(.. "(" entry.type ")") "TabLine"]]))

(defn- entry-maker [entry]
  {:value entry
   :name entry.name
   :type entry.type
   :ns entry.ns
   :symbol (.. entry.ns "/" entry.name)
   :display make-display
   :ordinal (.. entry.ns " " entry.name " " entry.type)})

(defn- set-lines [bufnr ext symbol]
  (vim.api.nvim_buf_set_lines
    bufnr 0 -1 false (db.preview ext symbol)))

(def previewer
  (defaulter
    (fn [opts]
      (previewers.new_buffer_previewer
        {:keep_last_buf true
         :get_buffer_by_name (fn [_ entry] entry.symbol)
         :define_preview
         (fn [self entry status]
           (when (not= entry.symbol self.state.bufname)
             (set-lines self.state.bufnr opts.ext entry.symbol)
             (vim.api.nvim_win_set_option self.state.preview_win "wrap" true)
             (putils.highlighter self.state.bufnr "markdown")))})) {}))

(defn- lispdocs-find [opts]
  (var opts (or opts {}))
  ;; TODO: change to the current file extension
  (tset opts :ext (or opts.ext "clj"))
  (var config
    {:finder (finders.new_table
               {:results (db.all opts.ext)
                :entry_maker (fn [entry]
                               {:value entry
                                :name entry.name
                                :type entry.type
                                :ext opts.ext
                                :ns entry.ns
                                :symbol (.. entry.ns "/" entry.name)
                                :display make-display
                                :ordinal (.. entry.ns " "
                                             entry.name " "
                                             entry.type)})})
     :prompt_title "Lispdocs"
     :sorter (conf.values.generic_sorter opts)
     :previewer (previewer.new opts)})
  (: (pickers.new opts config) :find))


(telescope.register_extension
  {:exports
   {:lispdocs lispdocs-find}})
