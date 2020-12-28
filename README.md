# conjure-clojuredocs

View community usage examples/notes from within your editor.

![](./docs/preview.gif)


This implementation requires downloading https://gist.github.com/tami5/14c0098691ce57b1c380c9c91dbdd322 to `~/.cache/conjure/clj-docs.fnl` which is a snapshot of
https://clojuredocs.org/clojuredocs-export.json. If the file doesn't exists the plugin will download it automatically.

Please open an issue if you have better suggestion or implementation.

## Installation 

```vim
Plug 'tami6/conjure-clojuredocs' " its a filetype plugin so no need to do any extra work.
```

Mappings: 

- `<leader>hh` open a float
- `<leader>hv` open vsplit
- `<leader>hs` open split

Options:

disable default mappings: `let g:conjure_clojuredocs_mappings = 0`

## API

`conjure.clojuredocs` functions takes a dict defining the following items. Everything is optional, unless you want to use `conjure.clojuredocs.display-docs` directly, then the first one is required.

- `opts.display`: which display type to use, "vsplit", "float", "split". o
- `opts.win`: float options (look at vim.w), most notably `winhl` which the background highlighting and `winblend` for transparency 
- `opts.symbol`: The symbol to search for.
- `opts.fill`: How much the float window should cover, default 80% or as the option expect `0.8` .
- `opts.border`: the float window chars, see default `["─" "│" "╭" "╮" "╰" "╯"]`.
- `opts.buf`: buffer specific options, applies to all display types, (see vim.bo).

Examples:

```vim
nnoremap <leader><cr> :lua require'conjure.clojuredocs'.float{ fill = 0.5, win = { winblend = 0, :cursorline false }}<cr>
nnoremap <leader>clojure :lua require'conjure.clojuredocs'.split{ buf = {ft = "clojure"}}<cr> " bad idea
```

## Todos

- [ ] refactor: use conjure.promise (awaiting @Olical review)
- [ ] enable navigation between symbol docs through `See Also` section.
- [ ] Return an error msg if a symbol is not found
- [ ] create a fuzzy finder using telescope.nvim that fetch the content of symbols and enable users to search for them.
- [ ] support ClojureScript
- [ ] maintain/update clojuredocs buffer, such as requesting new symbol update the open buffer
