(module lispdocs
  {require {a       conjure.aniseed.core
            client  conjure.client
            eval    conjure.eval
            db      lispdocs.db
            util    lispdocs.util
            display lispdocs.display
            notify  lispdocs.notify
            finder  lispdocs.finder}})

(defn- get-preview [tbl symbol]
  (-?> {:keys ["preview"] :where {: symbol}}
       (tbl:get)
       (. 1)
       (. :preview)
       (vim.split "||00||")))

(defn- resolve* [ext res cb]
  (let [symbol  (res:gsub "#'" "")
        tbl     (or (. db ext) {})]
    (if (and (util.supported ext)
             (not (tbl:empty)))
      (cb (get-preview tbl symbol))
      (tbl:seed #(cb (preview))))))

(defn- resolve [origin ext symbol cb]
  (let [code (string.format "(resolve '%s)" symbol)
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
  (let [ext     (or opts.ext (vim.fn.expand "%:e"))
        symbol  (or opts.symbol (vim.fn.expand "<cword>"))
        filetype (util.get-ft ext)
        resolve #(resolve filetype ext symbol $1)]
    (resolve
      #(display.open
         (if (not (a.empty? $1))
           (-> opts
               (a.assoc :content $1)
               (a.assoc-in [:buf :filetype]
                           (or (a.get-in opts [:buf :filetype])
                               (util.get-preview-ft ext))))
           (notify.symbol-not-found symbol))))))

{: display-docs
 :float  #(display-docs (a.merge {:display :float} $1))
 :vsplit #(display-docs (a.merge {:display :vsplit} $1))
 :split  #(display-docs (a.merge {:display :split}) $1)
 :normal #(display-docs (a.merge {:display :normal}) $1)
 :find finder.find}
