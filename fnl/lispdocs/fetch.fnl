(module lispdocs.fetch
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            util lispdocs.util}})

(defn- get-url [ext]
  (match ext
    "clj" "https://clojuredocs.org/clojuredocs-export.json"
    "cljc" "https://clojuredocs.org/clojuredocs-export.json"))

(defn- get-tmp-path [ext]
  (match ext
    "clj"  "/tmp/cljex.json"
    "cljc" "/tmp/cljex.json"))

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

(defn- dl [ext cb]
  "Download doc usage file."
  (when (not (tmp-file-exists? ext))
    (vim.fn.jobstart
      ["curl" "-L" (get-url ext) "-o" (get-tmp-path ext)]
      {:on_exit #(if (tmp-file-exists? ext)
                   (do (print (dl-succ ext))
                     (cb true))
                   (cb false))})))

(defn- json-parse [ext]
  (let [path (get-tmp-path ext)
        file (io.open path)
        json (file:read "*all")]
    (file:close)
    (vim.fn.json_decode json)))

(defn data [cb ext]
  "return lua table for ext's json"
  (if (not (tmp-file-exists? ext))
    (do (print (dl-msg ext))
      (dl ext
          #(if $1
             (cb (json-parse ext))
             (error (dl-err ext)))))
    (cb (json-parse ext))))
