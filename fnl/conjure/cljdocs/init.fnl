(module conjure.cljdocs
  {require {nvim conjure.aniseed.nvim
            a conjure.aniseed.core
            client conjure.client
            eval conjure.eval
            db conjure.cljdocs.db
            display conjure.cljdocs.display}})


(defn- get-origin [ext]
  (match ext
    "clj" "clojure"
    _ (error (.. "lspdocs: " (vim.fn.expand "%:e") " is not supported"))))

(defn- reslove-symbol [cb ext symbol]
  (client.with-filetype (get-origin ext) eval.eval-str
                        {:origin (get-origin ext)
                         :code (string.format "(resolve '%s)" symbol)
                         :passive? true
                         :on-result #(cb (db.preview ext (string.gsub $1 "#'" "")))}))

(defn display-docs [opts]
  "Main function of this namespace.
   Accepts a map defining a set configuration options.
   opts.symbol    :str:     The symbol to search for.
   opts.display*  :str:     Display type: split, vsplit or float.
   opts.win       :dict:    Float window options.
   opts.fill      :num:     Float window size.
   opts.border    :list:    Float window Border.
   opts.buf       :dict:    Buffer specfic options."
  (let [symbol (or opts.symbol (vim.fn.expand "<cword>"))
        ext (vim.fn.expand "%:e")]
    (reslove-symbol
      #(display.open
         (if (a.empty? $1)
           ;; TODO: should also log to conjure buffer
           (print (string.format "lspdocs.nvim: %s not found" symbol))
           (a.assoc opts :content $1)))
      ext symbol)))

(defn float [opts]
  (display-docs
    (a.merge {:display :float} opts)))

(defn vsplit [opts]
  (display-docs
    (a.merge {:display :vsplit} opts)))

(defn split [opts]
  (display-docs
    (a.merge {:display :split}) opts))

