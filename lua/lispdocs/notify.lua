local _0_0 = nil
do
  local name_0_ = "lispdocs.notify"
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
    return {}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.notify"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local prefix = nil
do
  local v_0_ = nil
  do
    local v_0_0 = "lispdocs.nvim:"
    _0_0["prefix"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["prefix"] = v_0_
  prefix = v_0_
end
local symbol_not_found = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function symbol_not_found0(symbol)
      local msg = (prefix .. "'" .. symbol .. "' is not found")
      return print(msg)
    end
    v_0_0 = symbol_not_found0
    _0_0["symbol-not-found"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["symbol-not-found"] = v_0_
  symbol_not_found = v_0_
end
local downloading_data = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function downloading_data0(ext)
      local msg = (prefix .. "Caching data for" .. ext .. ".....")
      return print(msg)
    end
    v_0_0 = downloading_data0
    _0_0["downloading-data"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["downloading-data"] = v_0_
  downloading_data = v_0_
end
local download_fail = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function download_fail0(ext)
      local msg = (prefix .. "Couldn't download data for " .. ext .. " processing, Try again or report issue.")
      return print(msg)
    end
    v_0_0 = download_fail0
    _0_0["download-fail"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["download-fail"] = v_0_
  download_fail = v_0_
end
local downloaded = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function downloaded0(ext)
      local msg = (prefix .. ext .. "docs has been downloaded successfully.")
      return print(msg)
    end
    v_0_0 = downloaded0
    _0_0["downloaded"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["downloaded"] = v_0_
  downloaded = v_0_
end
return nil