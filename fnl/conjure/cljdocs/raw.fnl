(module conjure.cljdocs.raw
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            util conjure.cljdocs.util
            parse conjure.cljdocs.parse}})

(defn- url [ext]
  (match ext
    "clj" "https://clojuredocs.org/clojuredocs-export.json"))

(defn- tmp-file [ext]
  (match ext
    "clj" "/tmp/cljex.json"))

(defn- dl-msg [ext]
  (str.join " " ["Caching Docs and Usage Examples for" ext
                 "....."]))

(defn- dl-err [ext]
  (str.join " " ["Docs and Usage Examples for" ext
                 "Couldn't downloaded for processing,"
                 "try again or report issue."]))

(defn- dl-succ [ext]
  (str.join " " ["Docs and usage examples for" ext
                 "has been downloaded and about to get cached"]))

(defn- fix-datatypes [v]
  (let [list-string (fn [v] (if (= "table" (type v)) (str.join "||00|| " v) v))
        boolean-int (fn [v] (if (= "boolean" (type v)) (if (= v true) 1 0) v))
        vimnil-nil  (fn [v] (if (= "userdata" (type v)) nil v))]
    (-> v
        list-string
        boolean-int
        vimnil-nil)))

(defn- tmp-file-exists? [ext]
  "Checks if the temp file for {ext} exists"
  (let [path (tmp-file ext)]
    (and (util.exists? path)
         (> (. (vim.loop.fs_stat path) :size)
            1700))))

(defn download-raw-data [ext]
  "Download doc usage file."
  (var downloaded nil)
  (when (not (tmp-file-exists? ext))
    (vim.fn.jobstart
      ["curl" "-L" (url ext) "-o" (tmp-file ext)]
      {:on_exit #(if (tmp-file-exists? ext)
                    (set downloaded true)
                    (set downloaded false))})
    ;; TODO: find better non-blocking way.
    (vim.wait 100000 #(or (= downloaded true)
                          (= downloaded false))))
  (assert downloaded (dl-err ext))
  (print (dl-succ ext)))


(defn- get-raw-json-data [ext]
  "return lua table for ext's json"
  (let [path (tmp-file ext)
        valid (tmp-file-exists? ext)]
    (when (not valid)
      (print (dl-msg ext))
      (download-raw-data path))
    (let [file (io.open path)
          json (file:read "*all")]
      (file:close)
      (vim.fn.json_decode json))))

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
           (-> (get-raw-json-data "clj")
               (. :vars)))))

(defn get [ext]
  (match ext
   "clj" (get-clj)))
