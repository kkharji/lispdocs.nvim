local _2afile_2a = "fnl/lispdocs/db.fnl"
local _2amodule_name_2a = "lispdocs.db"
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
local a, raw, sqlite, str, util = require("conjure.aniseed.core"), require("lispdocs.raw"), require("sqlite"), require("conjure.aniseed.string"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["raw"] = raw
_2amodule_locals_2a["sqlite"] = sqlite
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local db
do
  local schema = {id = {"integer", "primary", "key"}, ns = "text", name = "text", symbol = "text", arglists = "text", doc = "text", preview = "text", examples = "text", macro = "integer", static = "integer", see_alsos = "text", type = "text", notes = "text"}
  local uri = (vim.fn.stdpath("data") .. "/lispdocs.db")
  db = sqlite({uri = uri, clj = schema, cljc = schema})
end
_2amodule_locals_2a["db"] = db
local function seed(type)
  local function _1_(self, cb)
    local function _2_(_241)
      self:insert(_241)
      return cb()
    end
    return raw.get(_2_, type)
  end
  return _1_
end
_2amodule_locals_2a["seed"] = seed
db.clj["seed"] = seed("clj")
do end (db.cljc)["seed"] = seed("cljc")
return db