local _0_0 = nil
do
  local name_0_ = "lispdocs.db"
  local module_0_ = nil
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("conjure.aniseed.core"), require("lispdocs.raw"), require("sqlite"), require("conjure.aniseed.string"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", raw = "lispdocs.raw", sqlite = "sqlite", str = "conjure.aniseed.string", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local raw = _local_0_[2]
local sqlite = _local_0_[3]
local str = _local_0_[4]
local util = _local_0_[5]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.db"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local db = nil
do
  local v_0_ = sqlite({clj = {arglists = "text", doc = "text", examples = "text", id = {"integer", "primary", "key"}, macro = "integer", name = "text", notes = "text", ns = "text", preview = "text", see_alsos = "text", static = "integer", symbol = "text", type = "text"}, uri = (vim.fn.stdpath("data") .. "/lispdocs.db")})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["db"] = v_0_
  db = v_0_
end
local function _2_(self, cb)
  local function _3_(_241)
    self:insert(_241)
    return cb()
  end
  return raw.get(_3_, "clj")
end
db.clj["seed"] = _2_
return db