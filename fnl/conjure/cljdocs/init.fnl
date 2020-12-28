(module conjure.cljdocs
  {require {nvim conjure.aniseed.nvim
            a conjure.aniseed.core
            client conjure.client
            eval conjure.eval
            parse conjure.cljdocs.parse
            display conjure.cljdocs.display
            fetch conjure.cljdocs.fetch}})

(defonce cljdocs (fetch.parse))

(defn- get-symbol-ns [cb symbol]
  (client.with-filetype
    :clojure eval.eval-str
    {:origin :clojure
     :code (string.format "(resolve '%s)" symbol)
     :passive? true
     :on-result #(cb (. cljdocs (string.gsub $1 "#'" "")))}))

(defn display-docs [opts]
  "Main function of this namespace.
    Accepts a map defining a set configuration options.
    opts.symbol    :str:     The symbol to search for.
    opts.display*  :str:     Display type: split, vsplit or float.
    opts.win       :dict:    Float window options.
    opts.fill      :num:     Float window size.
    opts.border    :list:    Float window Border.
    opts.buf       :dict:    Buffer specfic options."
  (let [symbol (or opts.symbol (vim.fn.expand "<cword>"))]
    (get-symbol-ns
      #(display.open
         (if (a.nil? $1)
           ;; TODO: should also log to conjure buffer
           (print (string.format "%s not found" symbol))
           (->> (parse.markdown $1)
                (a.assoc opts :content)))) symbol)))

(defn float [opts]
  (display-docs
    (a.merge {:display :float} opts)))

(defn vsplit [opts]
  (display-docs
    (a.merge {:display :vsplit} opts)))

(defn split [opts]
  (display-docs
    (a.merge {:display :split}) opts))

