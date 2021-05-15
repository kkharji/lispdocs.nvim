if exists('g:loaded_lispdocs')
  finish
endif

let g:loaded_lispdocs = 1

" TODO: check if conjure exists before mapping???
if get(g:, "lispdocs_mappings", 1) == 1
  nn <silent><leader>hh :lua require'lispdocs'.float()<cr>
  nn <silent><leader>hv :lua require'lispdocs'.vsplit()<cr>
  nn <silent><leader>hs :lua require'lispdocs'.split()<cr>
  nn <silent><leader>hn :lua require'lispdocs'.normal()<cr>
endif
