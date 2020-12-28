(module conjure.clojuredocs.fetch
  {require {a conjure.aniseed.core
            str conjure.aniseed.string
            fennel conjure.aniseed.fennel}})

(defn- exists? [p]
  "Takes a path and returns its type if its exists."
  (assert
    (= "string" (type p))
    (.. "`exists` expected string got " (type p)))
  (let [stat (vim.loop.fs_stat p)]
    (if stat stat.type false)))

(defn- ensure [p]
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

(defn- cache-dir []
  "Return $XDG_CACHE_HOME/conjure.
  Defaulting the cache directory to $HOME/.cache."
  (ensure (..  (or (os.getenv "XDG_CACHE_HOME")
                   (.. (os.getenv "HOME") "/.cache"))
              "/conjure")))

(def- url
  (str.join
    ["https://gist.githubusercontent.com"
     "/tami5/"
     "14c0098691ce57b1c380c9c91dbdd322"
     "/raw/"
     "b859bd867115960bc72a49903e2b8de0ce249c31"
     "/clojure.docs.fnl"]))

(def- path
  (.. (cache-dir) "/" "clj-docs.fnl"))

(defn download [callback]
  "Download doc usage file."
  (let [msg "Downloading clojuredocs.fnl to $XDG_CACHE_HOME/conjure/clj-docs.fnl ..."
        err "Couldn't download clojuredocs.fnl, try again or report issue."
        valid #(and (exists? path)
                    (> (. (vim.loop.fs_stat path) :size) 1700))]

    (if (valid) (callback)
      (do (print msg)
        (vim.fn.jobstart
          ["curl" "-L" url "-o" path]
          {:on_exit #(if (valid) (callback) (print err))})))))

(defn update [cb]
  "Redownload client usage defs/file."
  (vim.fn.jobstart
    ["rm" path]
    {:on_exit #(download cb)}))

(defn parse []
 (fennel.dofile path))

