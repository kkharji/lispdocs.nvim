(module conjure.cljdocs.db
  {require {a :conjure.aniseed.core
            str :conjure.aniseed.string
            util :conjure.cljdocs.util
            raw :conjure.cljdocs.raw
            sql :sql}})


(def- dbpath (.. (util.cache-dir) "/usage_docs.db"))

(def- db (sql.new dbpath))

(def- schemas
  {"clj" {:id ["integer" "primary" "key"]
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
          :ensure true}})

(defn- seed-clj [cb]
  (db:with_open
    #(let [items (raw.get "clj")]
       (db:create :clj (. schemas :clj))
       (db:insert :clj items)
       (when cb (cb)))))

(defn- seed [ext cb]
  (match ext
    "clj" (seed-clj cb)
    _ (error (string.format "lspdocs.nvim: File extension: %s is not supported." ext))))

(defn- query* [ext symbol preview]
  (let [res (-> (db:select ext {:where {:symbol symbol}}) (. 1))]
    (if preview
      (-?> res
           (. :preview)
           (vim.split "||00||"))
      res)))

(defn query [ext symbol preview]
  (db:with_open
    #(let [exists (db:exists ext)]
       (if (not exists)
         (seed ext #(query* ext symbol preview))
         (query* ext symbol preview)))))

(defn preview [ext symbol]
  (query ext symbol true))
