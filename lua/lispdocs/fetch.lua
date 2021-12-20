local _2afile_2a = "fnl/lispdocs/fetch.fnl"
local _2amodule_name_2a = "lispdocs.fetch"
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
local a, notify, str, util = require("conjure.aniseed.core"), require("lispdocs.notify"), require("conjure.aniseed.string"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["notify"] = notify
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local function tmp_file_exists_3f(ext)
  local path = util["get-docs-tmp-path"](ext)
  return (util["exists?"](path) and (vim.loop.fs_stat(path).size > 1700))
end
_2amodule_locals_2a["tmp-file-exists?"] = tmp_file_exists_3f
local function download(ext, cb)
  if not tmp_file_exists_3f(ext) then
    local function _1_()
      if tmp_file_exists_3f(ext) then
        print(notify.downloaded(ext))
        return cb(true)
      else
        return cb(false)
      end
    end
    return vim.fn.jobstart({"curl", "-L", util["get-docs-download-url"](ext), "-o", util["get-docs-tmp-path"](ext)}, {on_exit = _1_})
  else
    return nil
  end
end
_2amodule_locals_2a["download"] = download
local function json_parse(ext)
  local path = util["get-docs-download-url"](ext)
  local file = io.open(path)
  local json = file:read("*all")
  file:close()
  return vim.fn.json_decode(json)
end
_2amodule_locals_2a["json-parse"] = json_parse
local function data(cb, ext)
  if not tmp_file_exists_3f(ext) then
    print(notify["downloading-data"](ext))
    local function _4_(_241)
      if _241 then
        return cb(json_parse(ext))
      else
        return error(__fnl_global__download_2dfail(ext))
      end
    end
    return download(ext, _4_)
  else
    return cb(json_parse(ext))
  end
end
_2amodule_2a["data"] = data