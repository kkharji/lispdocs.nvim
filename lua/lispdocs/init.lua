local _0_0 = nil
do
  local name_0_ = "lispdocs"
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
    return {require("conjure.aniseed.core"), require("conjure.client"), require("lispdocs.db"), require("lispdocs.display"), require("conjure.eval"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", client = "conjure.client", db = "lispdocs.db", display = "lispdocs.display", eval = "conjure.eval", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local client = _local_0_[2]
local db = _local_0_[3]
local display = _local_0_[4]
local eval = _local_0_[5]
local util = _local_0_[6]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local get_ft = nil
do
  local v_0_ = nil
  local function get_ft0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return {"clj", "clojure"}
    elseif (_2_0 == "cljc") then
      return {"clj", "clojure"}
    else
      local _ = _2_0
      return error(("lspdocs.nvim: " .. ext .. " is not supported"))
    end
  end
  v_0_ = get_ft0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-ft"] = v_0_
  get_ft = v_0_
end
local get_preview = nil
do
  local v_0_ = nil
  local function get_preview0(ext, tbl, symbol)
    local tbl0 = (db[ext] or {})
    local _2_0 = (tbl0:get({keys = {"preview"}, where = {symbol = symbol}}))[1]
    if _2_0 then
      local _3_0 = (_2_0).preview
      if _3_0 then
        return vim.split(_3_0, "||00||")
      else
        return _3_0
      end
    else
      return _2_0
    end
  end
  v_0_ = get_preview0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-preview"] = v_0_
  get_preview = v_0_
end
local resolve_2a = nil
do
  local v_0_ = nil
  local function resolve_2a0(ext, res, cb)
    local symbol = res:gsub("#'", "")
    local tbl = (db[ext] or {})
    local valid = (util.supported(ext) and tbl.has_content)
    local preview = nil
    local function _2_()
      return get_preview(ext, tbl, symbol)
    end
    preview = _2_
    if valid then
      return cb(preview())
    else
      local function _3_()
        return cb(preview())
      end
      return tbl:seed(_3_)
    end
  end
  v_0_ = resolve_2a0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["resolve*"] = v_0_
  resolve_2a = v_0_
end
local resolve = nil
do
  local v_0_ = nil
  local function resolve0(ext, symbol, cb)
    local _let_0_ = get_ft(ext)
    local ext_alt = _let_0_[1]
    local origin = _let_0_[2]
    local code = string.format("(resolve '%s)", symbol)
    local on_result = nil
    local function _2_(_241)
      return resolve_2a(ext_alt, _241, cb)
    end
    on_result = _2_
    local passive_3f = true
    local args = {["on-result"] = on_result, ["passive?"] = passive_3f, code = code, origin = origin}
    return client["with-filetype"](origin, eval["eval-str"], args)
  end
  v_0_ = resolve0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["resolve"] = v_0_
  resolve = v_0_
end
local display_docs = nil
do
  local v_0_ = nil
  local function display_docs0(opts)
    local function _2_(_241, _242)
      local function _3_()
        if not a["empty?"](_241) then
          return a.assoc(opts, "content", _241)
        else
          return print(("lspdocs.nvim: " .. _242 .. " not found"))
        end
      end
      return display.open(_3_())
    end
    return resolve((opts.ext or vim.fn.expand("%:e")), (opts.symbol or vim.fn.expand("<cword>")), _2_)
  end
  v_0_ = display_docs0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["display-docs"] = v_0_
  display_docs = v_0_
end
local function _2_(_241)
  return display_docs(a.merge({display = "float"}, _241))
end
local function _3_(_241)
  return display_docs(a.merge({display = "normal"}), _241)
end
local function _4_(_241)
  return display_docs(a.merge({display = "split"}), _241)
end
local function _5_(_241)
  return display_docs(a.merge({display = "vsplit"}, _241))
end
return {["display-docs"] = display_docs, float = _2_, normal = _3_, split = _4_, vsplit = _5_}