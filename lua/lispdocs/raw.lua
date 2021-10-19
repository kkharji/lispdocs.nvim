local _2afile_2a = "fnl/lispdocs/raw.fnl"
local _2amodule_name_2a = "lispdocs.raw"
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
local a, fetch, parse, str, util = require("conjure.aniseed.core"), require("lispdocs.fetch"), require("lispdocs.parse"), require("conjure.aniseed.string"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["fetch"] = fetch
_2amodule_locals_2a["parse"] = parse
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local function fix_datatypes(v)
  local list_string
  local function _1_(v0)
    if ("table" == type(v0)) then
      return str.join("||00||", v0)
    else
      return v0
    end
  end
  list_string = _1_
  local boolean_int
  local function _3_(v0)
    if ("boolean" == type(v0)) then
      if (v0 == true) then
        return 1
      else
        return 0
      end
    else
      return v0
    end
  end
  boolean_int = _3_
  local vimnil_nil
  local function _6_(v0)
    if ("userdata" == type(v0)) then
      return nil
    else
      return v0
    end
  end
  vimnil_nil = _6_
  return vimnil_nil(boolean_int(list_string(v)))
end
_2amodule_locals_2a["fix-datatypes"] = fix_datatypes
local function see_also_item(i)
  if util["not-nil?"](i) then
    local v = i["to-var"]
    if util["not-nil?"](v) then
      return (v.ns .. "/" .. v.name)
    else
      return ""
    end
  else
    return ""
  end
end
_2amodule_locals_2a["see-also-item"] = see_also_item
local function see_alsos(i)
  local mapover
  local function _10_(_241)
    if util["not-nil?"](_241) then
      local _11_ = _241
      if (_11_ ~= nil) then
        return a.map(see_also_item, _11_)
      else
        return _11_
      end
    else
      return nil
    end
  end
  mapover = _10_
  return a.update(i, "see-alsos", mapover)
end
_2amodule_locals_2a["see-alsos"] = see_alsos
local function get_body(i)
  if util["not-nil?"](i) then
    local _14_ = i
    if (_14_ ~= nil) then
      local function _15_(_241)
        return (_241).body
      end
      return a.map(_15_, _14_)
    else
      return _14_
    end
  else
    return nil
  end
end
_2amodule_locals_2a["get-body"] = get_body
local function compact_clj_item(i)
  local notes
  local function _18_(_241)
    return a.update(_241, "notes", get_body)
  end
  notes = _18_
  local examples
  local function _19_(_241)
    return a.update(_241, "examples", get_body)
  end
  examples = _19_
  local item = a.assoc(i, "symbol", (i.ns .. "/" .. i.name))
  local _21_
  do
    local _20_ = item
    if (_20_ ~= nil) then
      local _22_ = see_alsos(_20_)
      if (_22_ ~= nil) then
        local _24_ = examples(_22_)
        if (_24_ ~= nil) then
          _21_ = notes(_24_)
        else
          _21_ = _24_
        end
      else
        _21_ = _22_
      end
    else
      _21_ = _20_
    end
  end
  return a["select-keys"](_21_, {"arglists", "doc", "notes", "examples", "name", "ns", "see-alsos", "static", "type", "symbol"})
end
_2amodule_locals_2a["compact-clj-item"] = compact_clj_item
local function format_clj_entry(item)
  local markdown = {preview = parse["parse-for"]("clj", item)}
  local res = {}
  a["merge!"](item, markdown)
  for k, v in pairs(item) do
    res[k:gsub("-", "_")] = fix_datatypes(v)
  end
  return res
end
_2amodule_locals_2a["format-clj-entry"] = format_clj_entry
local function get_clj(cb)
  local function _29_(_241)
    local _30_ = (_241).vars
    if (_30_ ~= nil) then
      local _31_ = a.map(compact_clj_item, _30_)
      if (_31_ ~= nil) then
        local _32_ = a.map(format_clj_entry, _31_)
        if (_32_ ~= nil) then
          return cb(_32_)
        else
          return _32_
        end
      else
        return _31_
      end
    else
      return _30_
    end
  end
  return fetch.data(_29_, "clj")
end
_2amodule_locals_2a["get-clj"] = get_clj
local function get(cb, ext)
  local _36_ = ext
  if (_36_ == "clj") then
    return get_clj(cb)
  else
    return nil
  end
end
_2amodule_2a["get"] = get