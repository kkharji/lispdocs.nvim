(module lispdocs
  {require {a conjure.aniseed.core
            client conjure.client
            eval conjure.eval
            db lispdocs.db
            util lispdocs.util
            display lispdocs.display
            finder lispdocs.finder}})

(defn- get-ft [ext]
  (match ext
    "clj" "clojure"
    _ (error (.. "lspdocs.nvim: " ext " is not supported"))))

(defn- get-preview [ext tbl symbol]
  (let [tbl (or (. db ext) {})]
    (-?> (. (tbl:get {:keys ["preview"] :where {: symbol}}) 1)
         (. :preview)
         (vim.split "||00||"))))

(defn- resolve* [ext res cb]
  (let [symbol (res:gsub "#'" "")
        tbl (or (. db ext) {})
        valid (and (util.supported ext) tbl.has_content)
        preview #(get-preview ext tbl symbol)]
    (if valid
      (cb (preview))
      (tbl:seed #(cb (preview))))))

(defn- resolve [ext symbol cb]
  (let [origin (get-ft ext)
        code (string.format "(resolve '%s)" symbol)
        on-result #(resolve* ext $1 cb)
        passive? true
        args {: origin : code  : passive?  : on-result}]
    (client.with-filetype origin eval.eval-str args)))

(defn- display-docs [opts]
  "Main function of this namespace.
   Accepts a map defining a set configuration options.
   opts.symbol    :str:     The symbol to search for.
   opts.display*  :str:     Display type: split, vsplit or float.
   opts.win       :dict:    Float window options.
   opts.fill      :num:     Float window size.
   opts.border    :list:    Float window Border.
   opts.buf       :dict:    Buffer specfic options."
  (resolve
    (or opts.ext (vim.fn.expand "%:e"))
    (or opts.symbol (vim.fn.expand "<cword>"))
    #(display.open
       (if (not (a.empty? $1))
         (a.assoc opts :content $1)
         (print (.. "lspdocs.nvim: " $2 " not found"))))))  ;; TODO: print log to conjure buffer

{: display-docs
 :float  #(display-docs (a.merge {:display :float} $1))
 :vsplit #(display-docs (a.merge {:display :vsplit} $1))
 :split  #(display-docs (a.merge {:display :split}) $1)
 :normal #(display-docs (a.merge {:display :normal}) $1)
 :find finder.find}
