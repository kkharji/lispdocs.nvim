(module lispdocs.notify)

(def prefix
  "lispdocs.nvim:")

(defn symbol-not-found [symbol]
  (let [msg (.. prefix "'" symbol "' is not found")]
    (print msg)))


(defn downloading-data [ext]
  (let [msg (.. prefix "Caching data for" ext ".....")]
    (print msg)))

(defn download-fail [ext]
  (let [msg (.. prefix "Couldn't download data for " ext
                " processing, Try again or report issue.")]
    (print msg)))

(defn downloaded [ext]
  (let [msg (.. prefix ext "docs has been downloaded successfully.")]
    (print msg)))

