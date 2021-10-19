local _2afile_2a = "fnl/lispdocs/parse.fnl"
local _2amodule_name_2a = "lispdocs.parse"
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
local a, str, util = require("conjure.aniseed.core"), require("conjure.aniseed.string"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local function format_list(title, xs, template)
  local res = {}
  local count = 1
  if (not a["nil?"](xs) or not a["empty?"](xs)) then
    table.insert(res, title)
    table.insert(res, "--------------")
    local function _1_(item)
      table.insert(res, vim.split(string.format(template, count, str.trim(item)), "\n"))
      count = (count + 1)
      return nil
    end
    a["run!"](_1_, xs)
    return vim.tbl_flatten(res)
  else
    return nil
  end
end
_2amodule_locals_2a["format-list"] = format_list
local function format_signture(name, arglists)
  if not a["empty?"](arglists) then
    local function _3_(_241)
      return string.format("`(%s %s)`", name, _241)
    end
    return {str.join(" ", a.map(_3_, arglists)), " "}
  else
    return nil
  end
end
_2amodule_locals_2a["format-signture"] = format_signture
local function format_doc(xs)
  if util["not-nil?"](xs) then
    return {a.map(str.trim, vim.split(xs, "\n")), ""}
  else
    return nil
  end
end
_2amodule_locals_2a["format-doc"] = format_doc
local function format_header(ns, name)
  if util["not-nil?"](name) then
    return {(ns .. "/" .. name), "=============="}
  else
    return nil
  end
end
_2amodule_locals_2a["format-header"] = format_header
local function format_see_also(items)
  if not a["empty?"](items) then
    local symbols
    local function _7_(_241)
      return string.format("* `%s`", _241)
    end
    symbols = a.map(_7_, items)
    return {"See Also", "--------------", symbols, " "}
  else
    return nil
  end
end
_2amodule_locals_2a["format-see-also"] = format_see_also
local function format_examples(examples)
  return format_list("Usage", examples, "### Example %d:\n\n```clojure\n%s\n```\n--------------\n")
end
_2amodule_locals_2a["format-examples"] = format_examples
local function format_notes(notes)
  return format_list("Notes", notes, "### Note %d:\n%s\n\n--------------\n")
end
_2amodule_locals_2a["format-notes"] = format_notes
local function clj_symbol(kv)
  if util["not-nil?"](kv) then
    return vim.tbl_flatten({format_header(kv.ns, kv.name), format_signture(kv.name, kv.arglists), format_doc(kv.doc), format_see_also(kv["see-alsos"]), format_examples(kv.examples), format_notes(kv.notes)})
  else
    return nil
  end
end
_2amodule_2a["clj-symbol"] = clj_symbol
local function parse_for(ext, kv)
  local _10_ = ext
  if (_10_ == "clj") then
    return clj_symbol(kv)
  else
    return nil
  end
end
_2amodule_2a["parse-for"] = parse_for