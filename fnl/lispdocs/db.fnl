(module lispdocs.db
  {require {a :conjure.aniseed.core
            str :conjure.aniseed.string
            util :lispdocs.util
            raw :lispdocs.raw
            sql :sql}})

(def- dbpath
  (-> (vim.fn.stdpath "data")
      (.. "/lispdocs.db")))

(def- db
  (sql.new dbpath))

{:clj (let [tbl (db:table "clj")]
        (tbl:schema
          {:id ["integer" "primary" "key"]
           :ns "text"
           :name "text"
           :symbol "text"
           :arglists "text"
           :doc "text"
           :preview "text"
           :examples "text"
           :macro "integer"
           :static "integer"
           :see_alsos "text"
           :type "text"
           :notes "text"
           :ensure true})
        (tset tbl :seed
              (fn [self cb]
                (raw.get #(do (self:insert $1) (cb)) "clj")))
        tbl)}
