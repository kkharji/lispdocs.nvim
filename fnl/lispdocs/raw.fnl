(module lispdocs.raw
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            util lispdocs.util
            fetch lispdocs.fetch
            parse lispdocs.parse}})

(defn- fix-datatypes [v]
  (let [list-string (fn [v] (if (= "table" (type v)) (str.join "||00||" v) v))
        boolean-int (fn [v] (if (= "boolean" (type v)) (if (= v true) 1 0) v))
        vimnil-nil  (fn [v] (if (= "userdata" (type v)) nil v))]
    (-> v
        list-string
        boolean-int
        vimnil-nil)))

(defn- see-also-item [i]
  (if (util.not-nil? i)
    (let [v (. i :to-var)]
      (if (util.not-nil? v)
        (.. (. v :ns) "/" (. v :name))
        "")) ""))

(defn- see-alsos [i]
  (let [mapover #(when (util.not-nil? $1)
                   (-?>> $1 (a.map see-also-item)))]
    (a.update i :see-alsos mapover)))

(defn- get-body [i]
  (when (util.not-nil? i)
    (-?>> i (a.map #(. $1 :body)))))

(defn- compact-clj-item [i]
  (let [notes #(a.update $1 :notes get-body)
        examples #(a.update $1 :examples get-body)
        item (a.assoc i :symbol (.. i.ns "/" i.name))]
    (-> (a.select-keys
          (-?>> item see-alsos examples notes)
          [:arglists :doc :notes :examples :name :ns :see-alsos :static :type :symbol]))))

(defn- format-clj-entry [item]
  (let [markdown {:preview (parse.parse-for "clj" item)}
        res {}]
    (a.merge! item markdown)
    (each [k v (pairs item)]
      (tset res (k:gsub "-" "_") (fix-datatypes v)))
    res))

(defn- get-clj []
  (a.map format-clj-entry
    (a.map compact-clj-item
           (-> (fetch.data "clj")
               (. :vars)))))

(defn get [ext]
  (match ext
   "clj" (get-clj)))
