local _0_0 = nil
do
  local name_0_ = "conjure.cljdocs.db"
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
    return {require("conjure.aniseed.core"), require("conjure.cljdocs.raw"), require("sql"), require("conjure.aniseed.string"), require("conjure.cljdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", raw = "conjure.cljdocs.raw", sql = "sql", str = "conjure.aniseed.string", util = "conjure.cljdocs.util"}}
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
local _2amodule_name_2a = "conjure.cljdocs.db"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local dbpath = nil
do
  local v_0_ = (util["cache-dir"]() .. "/usage_docs.db")
  _0_0["aniseed/locals"]["dbpath"] = v_0_
  dbpath = v_0_
end
local db = nil
do
  local v_0_ = sql.new(dbpath)
  _0_0["aniseed/locals"]["db"] = v_0_
  db = v_0_
end
local schemas = nil
do
  local v_0_ = {clj = {arglists = "text", doc = "text", ensure = true, examples = "text", id = {"integer", "primary", "key"}, macro = "integer", name = "text", notes = "text", ns = "text", preview = "text", see_alsos = "text", static = "integer", symbol = "text", type = "text"}}
  _0_0["aniseed/locals"]["schemas"] = v_0_
  schemas = v_0_
end
local seed_clj = nil
do
  local v_0_ = nil
  local function seed_clj0(cb)
    local function _2_()
      local items = raw.get("clj")
      db:create("clj", schemas.clj)
      db:insert("clj", items)
      if cb then
        return cb()
      end
    end
    return db:with_open(_2_)
  end
  v_0_ = seed_clj0
  _0_0["aniseed/locals"]["seed-clj"] = v_0_
  seed_clj = v_0_
end
local seed = nil
do
  local v_0_ = nil
  local function seed0(ext, cb)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return seed_clj(cb)
    else
      local _ = _2_0
      return error(string.format("lspdocs.nvim: File extension: %s is not supported.", ext))
    end
  end
  v_0_ = seed0
  _0_0["aniseed/locals"]["seed"] = v_0_
  seed = v_0_
end
local query_2a = nil
do
  local v_0_ = nil
  local function query_2a0(ext, symbol, preview)
    local res = (db:select(ext, {where = {symbol = symbol}}))[1]
    if preview then
      local _2_0 = res
      if _2_0 then
        local _3_0 = _2_0.preview
        if _3_0 then
          return vim.split(_3_0, "||00||")
        else
          return _3_0
        end
      else
        return _2_0
      end
    else
      return res
    end
  end
  v_0_ = query_2a0
  _0_0["aniseed/locals"]["query*"] = v_0_
  query_2a = v_0_
end
local query = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function query0(ext, symbol, preview)
      local function _2_()
        local exists = db:exists(ext)
        if not exists then
          local function _3_()
            return query_2a(ext, symbol, preview)
          end
          return seed(ext, _3_)
        else
          return query_2a(ext, symbol, preview)
        end
      end
      return db:with_open(_2_)
    end
    v_0_0 = query0
    _0_0["query"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["query"] = v_0_
  query = v_0_
end
local preview = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function preview0(ext, symbol)
      return query(ext, symbol, true)
    end
    v_0_0 = preview0
    _0_0["preview"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["preview"] = v_0_
  preview = v_0_
end
return nil