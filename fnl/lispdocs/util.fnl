(module lispdocs.util
  {require {a conjure.aniseed.core
            str conjure.aniseed.string}})

(defn exists? [p]
  "Takes a path and returns its type if its exists."
  (assert
    (= "string" (type p))
    (.. "`exists` expected string got " (type p)))
  (let [stat (vim.loop.fs_stat p)]
    (if stat stat.type false)))

(defn ensure [p]
  "Takes a path and ensure it exist."
  (assert
    (= :string (type p))
    (.. "`ensure` expected string got " (type p)))
  (when (not (exists? p))
    (if (= nil (string.match p "%.%w+"))
      (let [handle (vim.loop.fs_open p "w" 438)]
        (vim.loop.fs_close handle))
      (vim.loop.fs_mkdir p 493)))
  p)

(defn cache-dir []
  "Return $XDG_CACHE_HOME/conjure.
  Defaulting the cache directory to $HOME/.cache."
  (ensure (..  (or (os.getenv "XDG_CACHE_HOME")
                   (.. (os.getenv "HOME") "/.cache"))
              "/conjure")))

(defn not-nil? [v]
  (and (not (a.nil? v))
       (not= "userdata" (type v))))

(defn supported [ext]
  (match ext ;; get filetype from extension.
    "clj" true
    "cljc" true
    _ (error (.. "lspdocs: " ext " is not supported"))))

(defn get-ft [ext]
  (match ext
    "clj" "clojure"
    "cljc" "clojure"
    _ (error (.. "lspdocs.nvim: " (or ext "unknown!") " is not supported"))))

(defn get-preview-ft [ext]
  (. vim.g (.. "lispdocs_" (or (get-ft ext) "") "_preview_ft")))

(defn get-docs-download-url [ext]
  (match ext
    "clj" "https://clojuredocs.org/clojuredocs-export.json"
    "cljc" "https://clojuredocs.org/clojuredocs-export.json"))

(defn get-docs-tmp-path [ext]
  (match ext
    "clj"  "/tmp/cljex.json"
    "cljc" "/tmp/cljex.json"))

