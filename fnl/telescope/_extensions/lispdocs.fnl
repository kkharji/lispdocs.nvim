(module telescope.__extensions.lispdocs
  {require {util lispdocs.util
            finder :lispdocs.finder}})

(telescope.register_extension {:exports {:lispdocs finder.find}})
