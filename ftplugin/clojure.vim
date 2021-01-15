if exists('g:loaded_conjure_cljdocs')
  finish
endif

let g:loaded_conjure_cljdocs = 1

" TODO: check if conjure exists before mapping???
if get(g:, "conjure_cljdocs_mappings", 1) == 1
  nn <silent><leader>hh :lua require'lispdocs'.float()<cr>
  nn <silent><leader>hv :lua require'lispdocs'.vsplit()<cr>
  nn <silent><leader>hs :lua require'lispdocs'.split()<cr>
endif
