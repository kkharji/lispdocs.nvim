(module conjure.clojuredocs.parse
  {require {a conjure.aniseed.core
            str conjure.aniseed.string}})

(defn markdown [kv]
  "Parses a symbol's dict to markdown section and content."
  (let [sec {:notes kv.notes
             :examples kv.examples
             :info kv.doc
             :also kv.see-alsos
             :signture [kv.name kv.arglists]
             :header [kv.ns kv.name]}
        formatlist (fn [xs title template] ;; TODO: Refactor
                     (var res [])
                     (var count 1)
                     (when (not (a.empty? xs))
                       (table.insert res title)
                       (table.insert res "--------------")
                       (a.run! (fn [item]
                                 (->> (-> template
                                          (string.format count (str.trim item))
                                          (vim.split "\n"))
                                      (table.insert res))
                                 (set count (+ count 1))) xs)
                       (vim.tbl_flatten res)))
        header [(string.format "%s/%s" (unpack sec.header))
                "=============="]
        signture [(->> (a.get-in sec [:signture 2])
                       (a.map #(string.format
                                 "`(%s %s)`"
                                 (a.get-in sec [:signture 1]) $1))
                       (str.join " ")) " "]
        info [(a.map str.trim (vim.split sec.info "\n")) " "]
        examples (formatlist
                   sec.examples "Usage"
                   "### Example %d:\n\n```clojure\n%s\n```\n--------------\n")
        notes (formatlist
                sec.notes "Notes"
                "### Note %d:\n%s\n\n--------------\n")
        see-also (when (not (a.empty? sec.also))
                   ["See Also" "--------------"
                    (a.map #(string.format "* `%s`" $1) sec.also) " "])]
    (vim.tbl_flatten [header signture info see-also examples notes])))

