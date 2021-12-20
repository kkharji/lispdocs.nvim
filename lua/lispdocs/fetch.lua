local _0_0 = nil
do
  local name_0_ = "lispdocs.fetch"
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
    return {require("conjure.aniseed.core"), require("lispdocs.notify"), require("conjure.aniseed.string"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", notify = "lispdocs.notify", str = "conjure.aniseed.string", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local notify = _local_0_[2]
local str = _local_0_[3]
local util = _local_0_[4]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.fetch"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local tmp_file_exists_3f = nil
do
  local v_0_ = nil
  local function tmp_file_exists_3f0(ext)
    local path = util["get-docs-tmp-path"](ext)
    return (util["exists?"](path) and (vim.loop.fs_stat(path).size > 1700))
  end
  v_0_ = tmp_file_exists_3f0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["tmp-file-exists?"] = v_0_
  tmp_file_exists_3f = v_0_
end
local download = nil
do
  local v_0_ = nil
  local function download0(ext, cb)
    if not tmp_file_exists_3f(ext) then
      local function _2_()
        if tmp_file_exists_3f(ext) then
          print(notify.downloaded(ext))
          return cb(true)
        else
          return cb(false)
        end
      end
      return vim.fn.jobstart({"curl", "-L", util["get-docs-download-url"](ext), "-o", util["get-docs-tmp-path"](ext)}, {on_exit = _2_})
    end
  end
  v_0_ = download0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["download"] = v_0_
  download = v_0_
end
local json_parse = nil
do
  local v_0_ = nil
  local function json_parse0(ext)
    local path = util["get-docs-download-url"](ext)
    local file = io.open(path)
    local json = file:read("*all")
    file:close()
    return vim.fn.json_decode(json)
  end
  v_0_ = json_parse0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["json-parse"] = v_0_
  json_parse = v_0_
end
local data = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function data0(cb, ext)
      if not tmp_file_exists_3f(ext) then
        print(notify["downloading-data"](ext))
        local function _2_(_241)
          if _241 then
            return cb(json_parse(ext))
          else
            return error(__fnl_global__download_2dfail(ext))
          end
        end
        return download(ext, _2_)
      else
        return cb(json_parse(ext))
      end
    end
    v_0_0 = data0
    _0_0["data"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["data"] = v_0_
  data = v_0_
end
return nil