(module lispdocs.db
  {require {a :conjure.aniseed.core
            str :conjure.aniseed.string
            util :lispdocs.util
            raw :lispdocs.raw
            sqlite :sqlite}})

(def- db
  (sqlite {:uri (-> (vim.fn.stdpath "data") (.. "/lispdocs.db"))
           :clj {:id ["integer" "primary" "key"]
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
                 }}))

(tset db.clj :seed
      (fn [self cb]
        (raw.get #(do (self:insert $1) (cb)) "clj")))

db
