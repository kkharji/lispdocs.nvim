(module lispdocs.fetch
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            util lispdocs.util}})

(defn- get-url [ext]
  (match ext
    "clj" "https://clojuredocs.org/clojuredocs-export.json"))

(defn- get-tmp-path [ext]
  (match ext
    "clj" "/tmp/cljex.json"))

(defn- dl-msg [ext]
  (str.join " " ["lspdocs.nvim: Caching data for" ext
                 "....."]))

(defn- dl-err [ext]
  (str.join " " ["lspdocs.nvim: Couldn't download data for " ext " processing,"
                 "try again or report issue."]))

(defn- dl-succ [ext]
  (str.join " " ["lispdocs.nvim: data for" ext
                 "has been downloaded successfully."]))

(defn- tmp-file-exists? [ext]
  "Checks if the temp file for {ext} exists"
  (let [path (get-tmp-path ext)]
    (and (util.exists? path)
         (> (. (vim.loop.fs_stat path) :size)
            1700))))

(defn- download [ext]
  "Download doc usage file."
  (var downloaded nil)
  (when (not (tmp-file-exists? ext))
    (vim.fn.jobstart
      ["curl" "-L" (get-url ext) "-o" (get-tmp-path ext)]
      {:on_exit #(if (tmp-file-exists? ext)
                    (set downloaded true)
                    (set downloaded false))})
    ;; TODO: find better non-blocking way.
    (vim.wait 100000 #(or (= downloaded true)
                          (= downloaded false)))
    (assert downloaded (dl-err ext))
    (print (dl-succ ext))))

(defn data [ext]
  "return lua table for ext's json"
  (let [path (get-tmp-path ext)
        valid (tmp-file-exists? ext)]
    (when (not valid)
      (print (dl-msg ext))
      (download ext))
    (let [file (io.open path)
          json (file:read "*all")]
      (file:close)
      (vim.fn.json_decode json))))
