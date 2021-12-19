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
local _2amodule_name_2a = "lispdocs.fetch"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local get_url = nil
do
  local v_0_ = nil
  local function get_url0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return "https://clojuredocs.org/clojuredocs-export.json"
    elseif (_2_0 == "cljc") then
      return "https://clojuredocs.org/clojuredocs-export.json"
    end
  end
  v_0_ = get_url0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-url"] = v_0_
  get_url = v_0_
end
local get_tmp_path = nil
do
  local v_0_ = nil
  local function get_tmp_path0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return "/tmp/cljex.json"
    elseif (_2_0 == "cljc") then
      return "/tmp/cljex.json"
    end
  end
  v_0_ = get_tmp_path0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-tmp-path"] = v_0_
  get_tmp_path = v_0_
end
local dl_msg = nil
do
  local v_0_ = nil
  local function dl_msg0(ext)
    return str.join(" ", {"lspdocs.nvim: Caching data for", ext, "....."})
  end
  v_0_ = dl_msg0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["dl-msg"] = v_0_
  dl_msg = v_0_
end
local dl_err = nil
do
  local v_0_ = nil
  local function dl_err0(ext)
    return str.join(" ", {"lspdocs.nvim: Couldn't download data for ", ext, " processing,", "try again or report issue."})
  end
  v_0_ = dl_err0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["dl-err"] = v_0_
  dl_err = v_0_
end
local dl_succ = nil
do
  local v_0_ = nil
  local function dl_succ0(ext)
    return str.join(" ", {"lispdocs.nvim: data for", ext, "has been downloaded successfully."})
  end
  v_0_ = dl_succ0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["dl-succ"] = v_0_
  dl_succ = v_0_
end
local tmp_file_exists_3f = nil
do
  local v_0_ = nil
  local function tmp_file_exists_3f0(ext)
    local path = get_tmp_path(ext)
    return (util["exists?"](path) and (vim.loop.fs_stat(path).size > 1700))
  end
  v_0_ = tmp_file_exists_3f0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["tmp-file-exists?"] = v_0_
  tmp_file_exists_3f = v_0_
end
local dl = nil
do
  local v_0_ = nil
  local function dl0(ext, cb)
    if not tmp_file_exists_3f(ext) then
      local function _2_()
        if tmp_file_exists_3f(ext) then
          print(dl_succ(ext))
          return cb(true)
        else
          return cb(false)
        end
      end
      return vim.fn.jobstart({"curl", "-L", get_url(ext), "-o", get_tmp_path(ext)}, {on_exit = _2_})
    end
  end
  v_0_ = dl0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["dl"] = v_0_
  dl = v_0_
end
local json_parse = nil
do
  local v_0_ = nil
  local function json_parse0(ext)
    local path = get_tmp_path(ext)
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
        print(dl_msg(ext))
        local function _2_(_241)
          if _241 then
            return cb(json_parse(ext))
          else
            return error(dl_err(ext))
          end
        end
        return dl(ext, _2_)
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