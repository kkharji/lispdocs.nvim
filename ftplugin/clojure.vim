if exists('g:loaded_conjure_clojure_docs')
  finish
endif

let g:loaded_conjure_clojure_docs = 1

" TODO: check if conjure exists before mapping
nn <silent><buffer><leader>hh :lua require('conjure.clojuredocs')['float']()<cr>
nn <silent><buffer><leader>hv :lua require('conjure.clojuredocs')['vsplit']()<cr>
nn <silent><buffer><leader>hs :lua require('conjure.clojuredocs')['split']()<cr>

