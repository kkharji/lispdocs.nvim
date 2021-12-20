local _2afile_2a = "fnl/lispdocs/util.fnl"
local _2amodule_name_2a = "lispdocs.util"
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
local a, str = require("conjure.aniseed.core"), require("conjure.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["str"] = str
local function exists_3f(p)
  assert(("string" == type(p)), ("`exists` expected string got " .. type(p)))
  local stat = vim.loop.fs_stat(p)
  if stat then
    return stat.type
  else
    return false
  end
end
_2amodule_2a["exists?"] = exists_3f
local function ensure(p)
  assert(("string" == type(p)), ("`ensure` expected string got " .. type(p)))
  if not exists_3f(p) then
    if (nil == string.match(p, "%.%w+")) then
      local handle = vim.loop.fs_open(p, "w", 438)
      vim.loop.fs_close(handle)
    else
      vim.loop.fs_mkdir(p, 493)
    end
  else
  end
  return p
end
_2amodule_2a["ensure"] = ensure
local function cache_dir()
  return ensure(((os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/conjure"))
end
_2amodule_2a["cache-dir"] = cache_dir
local function not_nil_3f(v)
  return (not a["nil?"](v) and ("userdata" ~= type(v)))
end
_2amodule_2a["not-nil?"] = not_nil_3f
local function supported(ext)
  local _4_ = ext
  if (_4_ == "clj") then
    return true
  elseif (_4_ == "cljc") then
    return true
  elseif true then
    local _ = _4_
    return error(("lspdocs: " .. ext .. " is not supported"))
  else
    return nil
  end
end
_2amodule_2a["supported"] = supported
local function get_ft(ext)
  local _6_ = ext
  if (_6_ == "clj") then
    return "clojure"
  elseif (_6_ == "cljc") then
    return "clojure"
  elseif true then
    local _ = _6_
    return error(("lspdocs.nvim: " .. (ext or "unknown!") .. " is not supported"))
  else
    return nil
  end
end
_2amodule_2a["get-ft"] = get_ft
local function get_preview_ft(ext)
  return vim.g[("lispdocs_" .. (get_ft(ext) or "") .. "_preview_ft")]
end
_2amodule_2a["get-preview-ft"] = get_preview_ft
local function get_docs_download_url(ext)
  local _8_ = ext
  if (_8_ == "clj") then
    return "https://clojuredocs.org/clojuredocs-export.json"
  elseif (_8_ == "cljc") then
    return "https://clojuredocs.org/clojuredocs-export.json"
  else
    return nil
  end
end
_2amodule_2a["get-docs-download-url"] = get_docs_download_url
local function get_docs_tmp_path(ext)
  local _10_ = ext
  if (_10_ == "clj") then
    return "/tmp/cljex.json"
  elseif (_10_ == "cljc") then
    return "/tmp/cljex.json"
  else
    return nil
  end
end
_2amodule_2a["get-docs-tmp-path"] = get_docs_tmp_path