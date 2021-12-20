local _2afile_2a = "fnl/lispdocs/notify.fnl"
local _2amodule_name_2a = "lispdocs.notify"
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
local prefix = "lispdocs.nvim:"
_2amodule_2a["prefix"] = prefix
local function symbol_not_found(symbol)
  local msg = (prefix .. "'" .. symbol .. "' is not found")
  return print(msg)
end
_2amodule_2a["symbol-not-found"] = symbol_not_found
local function downloading_data(ext)
  local msg = (prefix .. "Caching data for" .. ext .. ".....")
  return print(msg)
end
_2amodule_2a["downloading-data"] = downloading_data
local function download_fail(ext)
  local msg = (prefix .. "Couldn't download data for " .. ext .. " processing, Try again or report issue.")
  return print(msg)
end
_2amodule_2a["download-fail"] = download_fail
local function downloaded(ext)
  local msg = (prefix .. ext .. "docs has been downloaded successfully.")
  return print(msg)
end
_2amodule_2a["downloaded"] = downloaded