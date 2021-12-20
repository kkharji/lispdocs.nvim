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
    return {require("conjure.aniseed.core"), require("conjure.client"), require("lispdocs.db"), require("lispdocs.display"), require("conjure.eval"), require("lispdocs.finder"), require("lispdocs.notify"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", client = "conjure.client", db = "lispdocs.db", display = "lispdocs.display", eval = "conjure.eval", finder = "lispdocs.finder", notify = "lispdocs.notify", util = "lispdocs.util"}}
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
local finder = _local_0_[6]
local notify = _local_0_[7]
local util = _local_0_[8]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local get_preview = nil
do
  local v_0_ = nil
  local function get_preview0(tbl, symbol)
    local _2_0 = {keys = {"preview"}, where = {symbol = symbol}}
    if _2_0 then
      local _3_0 = tbl:get(_2_0)
      if _3_0 then
        local _4_0 = (_3_0)[1]
        if _4_0 then
          local _5_0 = (_4_0).preview
          if _5_0 then
            return vim.split(_5_0, "||00||")
          else
            return _5_0
          end
        else
          return _4_0
        end
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
    if (util.supported(ext) and not tbl:empty()) then
      return cb(get_preview(tbl, symbol))
    else
      local function _2_()
        return cb(preview())
      end
      return tbl:seed(_2_)
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
  local function resolve0(origin, ext, symbol, cb)
    local code = string.format("(resolve '%s)", symbol)
    local on_result = nil
    local function _2_(_241)
      return resolve_2a(ext, _241, cb)
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
    local ext = (opts.ext or vim.fn.expand("%:e"))
    local symbol = (opts.symbol or vim.fn.expand("<cword>"))
    local filetype = util["get-ft"](ext)
    local resolve0 = nil
    local function _2_(_241)
      return resolve(filetype, ext, symbol, _241)
    end
    resolve0 = _2_
    local function _3_(_241)
      local function _4_()
        if not a["empty?"](_241) then
          return a["assoc-in"](a.assoc(opts, "content", _241), {"buf", "filetype"}, (a["get-in"](opts, {"buf", "filetype"}) or util["get-preview-ft"](ext)))
        else
          return notify["symbol-not-found"](symbol)
        end
      end
      return display.open(_4_())
    end
    return resolve0(_3_)
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
return {["display-docs"] = display_docs, find = finder.find, float = _2_, normal = _3_, split = _4_, vsplit = _5_}