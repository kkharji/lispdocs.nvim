(module lispdocs.fetch
  {require {a      conjure.aniseed.core
            str    conjure.aniseed.string
            util   lispdocs.util
            notify lispdocs.notify}})

(defn- tmp-file-exists? [ext]
  "Checks if the temp file for {ext} exists"
  (let [path (util.get-docs-tmp-path ext)]
    (and (util.exists? path)
         (> (. (vim.loop.fs_stat path) :size)
            1700))))

(defn- download [ext cb]
  "Download doc usage file."
  (when (not (tmp-file-exists? ext))
    (vim.fn.jobstart
      ["curl"
       "-L"
       (util.get-docs-download-url ext)
       "-o"
       (util.get-docs-tmp-path ext)]
      {:on_exit #(if (tmp-file-exists? ext)
                   (do (print (notify.downloaded ext))
                     (cb true))
                   (cb false))})))

(defn- json-parse [ext]
  (let [path (util.get-docs-download-url ext)
        file (io.open path)
        json (file:read "*all")]
    (file:close)
    (vim.fn.json_decode json)))

(defn data [cb ext]
  "return lua table for ext's json"
  (if (not (tmp-file-exists? ext))
    (do (print (notify.downloading-data ext))
      (download
        ext
        #(if $1
           (cb (json-parse ext))
           (error (download-fail ext)))))
    (cb (json-parse ext))))
