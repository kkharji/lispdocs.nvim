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
  elseif (_1_ == "cljc") then
    return "clojure"
  elseif true then
    local _ = _1_
    return error(("lspdocs.nvim: " .. ext .. " is not supported"))
  else
    return nil
  end
end
_2amodule_locals_2a["get-ft"] = get_ft
local function get_preview(tbl, symbol)
  local _3_ = {keys = {"preview"}, where = {symbol = symbol}}
  if (nil ~= _3_) then
    local _4_ = tbl:get(_3_)
    if (nil ~= _4_) then
      local _5_ = (_4_)[1]
      if (nil ~= _5_) then
        local _6_ = (_5_).preview
        if (nil ~= _6_) then
          return vim.split(_6_, "||00||")
        else
          return _6_
        end
      else
        return _5_
      end
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
  print(not tbl:empty())
  if (util.supported(ext) and not tbl:empty()) then
    return cb(get_preview(tbl, symbol))
  else
    local function _11_()
      return cb(preview())
    end
    return tbl:seed(_11_)
  end
end
_2amodule_locals_2a["resolve*"] = resolve_2a
local function resolve(ext, symbol, cb)
  local origin = get_ft(ext)
  local code = string.format("(resolve '%s)", symbol)
  local on_result
  local function _13_(_241)
    return resolve_2a(ext, _241, cb)
  end
  on_result = _13_
  local passive_3f = true
  local args = {origin = origin, code = code, ["passive?"] = passive_3f, ["on-result"] = on_result}
  return client["with-filetype"](origin, eval["eval-str"], args)
end
_2amodule_locals_2a["resolve"] = resolve
local function display_docs(opts)
  local ext = (opts.ext or vim.fn.expand("%:e"))
  local symbol = (opts.symbol or vim.fn.expand("<cword>"))
  local error
  local function _14_()
    return print(("lspdocs.nvim: '" .. symbol .. "' is not found"))
  end
  error = _14_
  local resolve0
  local function _15_(_241)
    return resolve(ext, symbol, _241)
  end
  resolve0 = _15_
  local function _16_(_241)
    local function _17_()
      if not a["empty?"](_241) then
        return a.assoc(opts, "content", _241)
      else
        return error()
      end
    end
    return display.open(_17_())
  end
  return resolve0(_16_)
end
_2amodule_locals_2a["display-docs"] = display_docs
local function _18_(_241)
  return display_docs(a.merge({display = "float"}, _241))
end
local function _19_(_241)
  return display_docs(a.merge({display = "vsplit"}, _241))
end
local function _20_(_241)
  return display_docs(a.merge({display = "split"}), _241)
end
local function _21_(_241)
  return display_docs(a.merge({display = "normal"}), _241)
end
return {["display-docs"] = display_docs, float = _18_, vsplit = _19_, split = _20_, normal = _21_, find = finder.find}