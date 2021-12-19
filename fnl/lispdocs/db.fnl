(module lispdocs.db
  {require {a :conjure.aniseed.core
            str :conjure.aniseed.string
            util :lispdocs.util
            raw :lispdocs.raw
            sqlite :sqlite}})

(def- db
  (let [schema {:id ["integer" "primary" "key"]
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
                :notes "text"}
        uri (.. (vim.fn.stdpath "data") "/lispdocs.db")]
    (sqlite {:uri uri :clj schema :cljc schema})))

(defn- seed [type]
  (fn [self cb]
    (raw.get #(do (self:insert $1) (cb)) type)))

(tset db.clj :seed (seed "clj"))
(tset db.cljc :seed (seed "cljc"))

db
