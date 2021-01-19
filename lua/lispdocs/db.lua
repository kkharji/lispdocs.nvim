local _0_0 = nil
do
  local name_0_ = "lispdocs.db"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("conjure.aniseed.core"), require("lispdocs.raw"), require("sql"), require("conjure.aniseed.string"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", raw = "lispdocs.raw", sql = "sql", str = "conjure.aniseed.string", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local raw = _local_0_[2]
local sql = _local_0_[3]
local str = _local_0_[4]
local util = _local_0_[5]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.db"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local dbpath = nil
do
  local v_0_ = (vim.fn.stdpath("data") .. "/lispdocs.db")
  _0_0["aniseed/locals"]["dbpath"] = v_0_
  dbpath = v_0_
end
local db = nil
do
  local v_0_ = sql.new(dbpath)
  _0_0["aniseed/locals"]["db"] = v_0_
  db = v_0_
end
local _2_
do
  local tbl = db:table("clj")
  tbl:schema({arglists = "text", doc = "text", ensure = true, examples = "text", id = {"integer", "primary", "key"}, macro = "integer", name = "text", notes = "text", ns = "text", preview = "text", see_alsos = "text", static = "integer", symbol = "text", type = "text"})
  local function _3_(self, cb)
    local function _4_(_241)
      self:insert(_241)
      return cb()
    end
    return raw.get(_4_, "clj")
  end
  tbl["seed"] = _3_
  _2_ = tbl
end
return {clj = _2_}