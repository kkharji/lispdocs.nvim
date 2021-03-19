local _0_0 = nil
do
  local name_0_ = "lispdocs.parse"
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
    return {require("conjure.aniseed.core"), require("conjure.aniseed.string"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", str = "conjure.aniseed.string", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local str = _local_0_[2]
local util = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.parse"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local format_list = nil
do
  local v_0_ = nil
  local function format_list0(title, xs, template)
    local res = {}
    local count = 1
    if (not a["nil?"](xs) or not a["empty?"](xs)) then
      table.insert(res, title)
      table.insert(res, "--------------")
      local function _2_(item)
        table.insert(res, vim.split(string.format(template, count, str.trim(item)), "\n"))
        count = (count + 1)
        return nil
      end
      a["run!"](_2_, xs)
      return vim.tbl_flatten(res)
    end
  end
  v_0_ = format_list0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-list"] = v_0_
  format_list = v_0_
end
local format_signture = nil
do
  local v_0_ = nil
  local function format_signture0(name, arglists)
    if not a["empty?"](arglists) then
      local function _2_(_241)
        return string.format("`(%s %s)`", name, _241)
      end
      return {str.join(" ", a.map(_2_, arglists)), " "}
    end
  end
  v_0_ = format_signture0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-signture"] = v_0_
  format_signture = v_0_
end
local format_doc = nil
do
  local v_0_ = nil
  local function format_doc0(xs)
    if util["not-nil?"](xs) then
      return {a.map(str.trim, vim.split(xs, "\n")), ""}
    end
  end
  v_0_ = format_doc0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-doc"] = v_0_
  format_doc = v_0_
end
local format_header = nil
do
  local v_0_ = nil
  local function format_header0(ns, name)
    if util["not-nil?"](name) then
      return {(ns .. "/" .. name), "=============="}
    end
  end
  v_0_ = format_header0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-header"] = v_0_
  format_header = v_0_
end
local format_see_also = nil
do
  local v_0_ = nil
  local function format_see_also0(items)
    if not a["empty?"](items) then
      local symbols = nil
      local function _2_(_241)
        return string.format("* `%s`", _241)
      end
      symbols = a.map(_2_, items)
      return {"See Also", "--------------", symbols, " "}
    end
  end
  v_0_ = format_see_also0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-see-also"] = v_0_
  format_see_also = v_0_
end
local format_examples = nil
do
  local v_0_ = nil
  local function format_examples0(examples)
    return format_list("Usage", examples, "### Example %d:\n\n```clojure\n%s\n```\n--------------\n")
  end
  v_0_ = format_examples0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-examples"] = v_0_
  format_examples = v_0_
end
local format_notes = nil
do
  local v_0_ = nil
  local function format_notes0(notes)
    return format_list("Notes", notes, "### Note %d:\n%s\n\n--------------\n")
  end
  v_0_ = format_notes0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["format-notes"] = v_0_
  format_notes = v_0_
end
local clj_symbol = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function clj_symbol0(kv)
      if util["not-nil?"](kv) then
        return vim.tbl_flatten({format_header(kv.ns, kv.name), format_signture(kv.name, kv.arglists), format_doc(kv.doc), format_see_also(kv["see-alsos"]), format_examples(kv.examples), format_notes(kv.notes)})
      end
    end
    v_0_0 = clj_symbol0
    _0_0["clj-symbol"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["clj-symbol"] = v_0_
  clj_symbol = v_0_
end
local parse_for = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function parse_for0(ext, kv)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return clj_symbol(kv)
      end
    end
    v_0_0 = parse_for0
    _0_0["parse-for"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["parse-for"] = v_0_
  parse_for = v_0_
end
return nil