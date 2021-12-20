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
local a, client, db, display, eval, finder, notify, util = require("conjure.aniseed.core"), require("conjure.client"), require("lispdocs.db"), require("lispdocs.display"), require("conjure.eval"), require("lispdocs.finder"), require("lispdocs.notify"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["db"] = db
_2amodule_locals_2a["display"] = display
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["finder"] = finder
_2amodule_locals_2a["notify"] = notify
_2amodule_locals_2a["util"] = util
local function get_preview(tbl, symbol)
  local _1_ = {keys = {"preview"}, where = {symbol = symbol}}
  if (nil ~= _1_) then
    local _2_ = tbl:get(_1_)
    if (nil ~= _2_) then
      local _3_ = (_2_)[1]
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
    else
      return _2_
    end
  else
    return _1_
  end
end
_2amodule_locals_2a["get-preview"] = get_preview
local function resolve_2a(ext, res, cb)
  local symbol = res:gsub("#'", "")
  local tbl = (db[ext] or {})
  if (util.supported(ext) and not tbl:empty()) then
    return cb(get_preview(tbl, symbol))
  else
    local function _9_()
      return cb(preview())
    end
    return tbl:seed(_9_)
  end
end
_2amodule_locals_2a["resolve*"] = resolve_2a
local function resolve(origin, ext, symbol, cb)
  local code = string.format("(resolve '%s)", symbol)
  local on_result
  local function _11_(_241)
    return resolve_2a(ext, _241, cb)
  end
  on_result = _11_
  local passive_3f = true
  local args = {origin = origin, code = code, ["passive?"] = passive_3f, ["on-result"] = on_result}
  return client["with-filetype"](origin, eval["eval-str"], args)
end
_2amodule_locals_2a["resolve"] = resolve
local function display_docs(opts)
  local ext = (opts.ext or vim.fn.expand("%:e"))
  local symbol = (opts.symbol or vim.fn.expand("<cword>"))
  local filetype = util["get-ft"](ext)
  local resolve0
  local function _12_(_241)
    return resolve(filetype, ext, symbol, _241)
  end
  resolve0 = _12_
  local function _13_(_241)
    local function _14_()
      if not a["empty?"](_241) then
        return a["assoc-in"](a.assoc(opts, "content", _241), {"buf", "filetype"}, (a["get-in"](opts, {"buf", "filetype"}) or util["get-preview-ft"](ext)))
      else
        return notify["symbol-not-found"](symbol)
      end
    end
    return display.open(_14_())
  end
  return resolve0(_13_)
end
_2amodule_locals_2a["display-docs"] = display_docs
local function _15_(_241)
  return display_docs(a.merge({display = "float"}, _241))
end
local function _16_(_241)
  return display_docs(a.merge({display = "vsplit"}, _241))
end
local function _17_(_241)
  return display_docs(a.merge({display = "split"}), _241)
end
local function _18_(_241)
  return display_docs(a.merge({display = "normal"}), _241)
end
return {["display-docs"] = display_docs, float = _15_, vsplit = _16_, split = _17_, normal = _18_, find = finder.find}