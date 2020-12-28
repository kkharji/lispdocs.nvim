if exists('g:loaded_conjure_clojure_docs')
  finish
endif

let g:loaded_conjure_clojure_docs = 1

" TODO: check if conjure exists before mapping
" TODO: make optional?
nn <silent><leader>hh :lua require('conjure.clojuredocs')['float']()<cr>
nn <silent><leader>hv :lua require('conjure.clojuredocs')['vsplit']()<cr>
nn <silent><leader>hs :lua require('conjure.clojuredocs')['split']()<cr>

