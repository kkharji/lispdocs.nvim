# conjure-clojuredocs

View community usage examples/notes from within youe editor.

![](./docs/preview.gif)

This implementation requires downloading https://gist.github.com/tami5/14c0098691ce57b1c380c9c91dbdd322 to `~/.cache/conjure/clj-docs.fnl` which is a snapshot of
https://clojuredocs.org/clojuredocs-export.json. If the file doesn't exists the plugin will download it automatically  

I welcome any new suggestion to improve this implementation.

## Todos

- [ ] refactor: use conjure.promise (awaiting @Olical review)
- [ ] enable navigation between symbol docs through `See Also` section.
- [ ] Return an error msg if a symbol is not found
- [ ] create a fuzzy finder using telescope.nvim
  that fetch the
  content of symbols and enable users to search
  for them.
