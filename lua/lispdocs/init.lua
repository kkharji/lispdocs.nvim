local _2afile_2a = "fnl/lispdocs/init.fnl"
local _2amodule_name_2a = "lispdocs"
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
local a, client, db, display, eval, finder, util = require("conjure.aniseed.core"), require("conjure.client"), require("lispdocs.db"), require("lispdocs.display"), require("conjure.eval"), require("lispdocs.finder"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["db"] = db
_2amodule_locals_2a["display"] = display
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["finder"] = finder
_2amodule_locals_2a["util"] = util
local function get_ft(ext)
  local _1_ = ext
  if (_1_ == "clj") then
    return "clojure"
  elseif true then
    local _ = _1_
    return error(("lspdocs.nvim: " .. ext .. " is not supported"))
  else
    return nil
  end
end
_2amodule_locals_2a["get-ft"] = get_ft
local function get_preview(ext, tbl, symbol)
  local tbl0 = (db[ext] or {})
  local _3_ = (tbl0:get({keys = {"preview"}, where = {symbol = symbol}}))[1]
  if (nil ~= _3_) then
    local _4_ = (_3_).preview
    if (nil ~= _4_) then
      return vim.split(_4_, "||00||")
    else
      return _4_
    end
  else
    return _3_
  end
end
_2amodule_locals_2a["get-preview"] = get_preview
local function resolve_2a(ext, res, cb)
  local symbol = res:gsub("#'", "")
  local tbl = (db[ext] or {})
  local valid = (util.supported(ext) and tbl.has_content)
  local preview
  local function _7_()
    return get_preview(ext, tbl, symbol)
  end
  preview = _7_
  if valid then
    return cb(preview())
  else
    local function _8_()
      return cb(preview())
    end
    return tbl:seed(_8_)
  end
end
_2amodule_locals_2a["resolve*"] = resolve_2a
local function resolve(ext, symbol, cb)
  local origin = get_ft(ext)
  local code = string.format("(resolve '%s)", symbol)
  local on_result
  local function _10_(_241)
    return resolve_2a(ext, _241, cb)
  end
  on_result = _10_
  local passive_3f = true
  local args = {origin = origin, code = code, ["passive?"] = passive_3f, ["on-result"] = on_result}
  return client["with-filetype"](origin, eval["eval-str"], args)
end
_2amodule_locals_2a["resolve"] = resolve
local function display_docs(opts)
  local function _11_(_241, _242)
    local function _12_()
      if not a["empty?"](_241) then
        return a.assoc(opts, "content", _241)
      else
        return print(("lspdocs.nvim: " .. _242 .. " not found"))
      end
    end
    return display.open(_12_())
  end
  return resolve((opts.ext or vim.fn.expand("%:e")), (opts.symbol or vim.fn.expand("<cword>")), _11_)
end
_2amodule_locals_2a["display-docs"] = display_docs
local function _13_(_241)
  return display_docs(a.merge({display = "float"}, _241))
end
local function _14_(_241)
  return display_docs(a.merge({display = "vsplit"}, _241))
end
local function _15_(_241)
  return display_docs(a.merge({display = "split"}), _241)
end
local function _16_(_241)
  return display_docs(a.merge({display = "normal"}), _241)
end
return {["display-docs"] = display_docs, float = _13_, vsplit = _14_, split = _15_, normal = _16_, find = finder.find}