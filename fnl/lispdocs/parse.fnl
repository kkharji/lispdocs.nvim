(module lispdocs.parse
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            util lispdocs.util}})

(defn- format-list [title xs template] ;; TODO: Refactor
  (var res [])
  (var count 1)
  (when (or (not (a.nil? xs)) (not (a.empty? xs)))
    (table.insert res title)
    (table.insert res "--------------")
    (a.run! (fn [item]
              (->> (-> template
                       (string.format count (str.trim item))
                       (vim.split "\n"))
                   (table.insert res))
              (set count (+ count 1))) xs)
    (vim.tbl_flatten res)))

(defn- format-signture [name arglists]
  (when (not (a.empty? arglists))
    [(->> arglists
          (a.map #(string.format "`(%s %s)`" name $1))
          (str.join " ")) " "]))

(defn- format-doc [xs]
  (when (util.not-nil? xs)
    [(a.map str.trim (vim.split xs "\n")) ""]))

(defn- format-header [ns name]
  (when (and (util.not-nil? name))
    [(.. ns "/" name) "=============="]))

(defn- format-see-also [items]
  (when (not (a.empty? items))
    (let [symbols (a.map #(string.format "* `%s`" $1) items)]
      ["See Also" "--------------" symbols " "])))

(defn- format-examples [examples]
  (format-list
    "Usage" examples
    "### Example %d:\n\n```clojure\n%s\n```\n--------------\n"))

(defn- format-notes [notes]
  (format-list
    "Notes" notes
    "### Note %d:\n%s\n\n--------------\n"))

(defn clj-symbol [kv]
  "Parses a symbol's dict to markdown section and content."
  (when (util.not-nil? kv)
    (vim.tbl_flatten
      [(format-header kv.ns kv.name)
       (format-signture kv.name kv.arglists)
       (format-doc kv.doc)
       (format-see-also kv.see-alsos)
       (format-examples kv.examples)
       (format-notes kv.notes)])))

(defn parse-for [ext kv]
  (match ext
    "clj" (clj-symbol kv)))
