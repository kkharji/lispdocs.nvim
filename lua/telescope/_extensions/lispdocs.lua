local _2afile_2a = "fnl/telescope/_extensions/lispdocs.fnl"
local _2amodule_name_2a = "telescope.__extensions.lispdocs"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local finder, util = require("lispdocs.finder"), require("lispdocs.util")
do end (_2amodule_locals_2a)["finder"] = finder
_2amodule_locals_2a["util"] = util
return telescope.register_extension({exports = {lispdocs = finder.find}})