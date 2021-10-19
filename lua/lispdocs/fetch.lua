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
local a, str, util = require("conjure.aniseed.core"), require("conjure.aniseed.string"), require("lispdocs.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local function get_url(ext)
  local _1_ = ext
  if (_1_ == "clj") then
    return "https://clojuredocs.org/clojuredocs-export.json"
  else
    return nil
  end
end
_2amodule_locals_2a["get-url"] = get_url
local function get_tmp_path(ext)
  local _3_ = ext
  if (_3_ == "clj") then
    return "/tmp/cljex.json"
  else
    return nil
  end
end
_2amodule_locals_2a["get-tmp-path"] = get_tmp_path
local function dl_msg(ext)
  return str.join(" ", {"lspdocs.nvim: Caching data for", ext, "....."})
end
_2amodule_locals_2a["dl-msg"] = dl_msg
local function dl_err(ext)
  return str.join(" ", {"lspdocs.nvim: Couldn't download data for ", ext, " processing,", "try again or report issue."})
end
_2amodule_locals_2a["dl-err"] = dl_err
local function dl_succ(ext)
  return str.join(" ", {"lispdocs.nvim: data for", ext, "has been downloaded successfully."})
end
_2amodule_locals_2a["dl-succ"] = dl_succ
local function tmp_file_exists_3f(ext)
  local path = get_tmp_path(ext)
  return (util["exists?"](path) and (vim.loop.fs_stat(path).size > 1700))
end
_2amodule_locals_2a["tmp-file-exists?"] = tmp_file_exists_3f
local function dl(ext, cb)
  if not tmp_file_exists_3f(ext) then
    local function _5_()
      if tmp_file_exists_3f(ext) then
        print(dl_succ(ext))
        return cb(true)
      else
        return cb(false)
      end
    end
    return vim.fn.jobstart({"curl", "-L", get_url(ext), "-o", get_tmp_path(ext)}, {on_exit = _5_})
  else
    return nil
  end
end
_2amodule_locals_2a["dl"] = dl
local function json_parse(ext)
  local path = get_tmp_path(ext)
  local file = io.open(path)
  local json = file:read("*all")
  file:close()
  return vim.fn.json_decode(json)
end
_2amodule_locals_2a["json-parse"] = json_parse
local function data(cb, ext)
  if not tmp_file_exists_3f(ext) then
    print(dl_msg(ext))
    local function _8_(_241)
      if _241 then
        return cb(json_parse(ext))
      else
        return error(dl_err(ext))
      end
    end
    return dl(ext, _8_)
  else
    return cb(json_parse(ext))
  end
end
_2amodule_2a["data"] = data