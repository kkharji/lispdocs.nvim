local _0_0 = nil
do
  local name_0_ = "lispdocs.util"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("conjure.aniseed.core"), require("conjure.aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", str = "conjure.aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local str = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs.util"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local exists_3f = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function exists_3f0(p)
      assert(("string" == type(p)), ("`exists` expected string got " .. type(p)))
      local stat = vim.loop.fs_stat(p)
      if stat then
        return stat.type
      else
        return false
      end
    end
    v_0_0 = exists_3f0
    _0_0["exists?"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["exists?"] = v_0_
  exists_3f = v_0_
end
local ensure = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function ensure0(p)
      assert(("string" == type(p)), ("`ensure` expected string got " .. type(p)))
      if not exists_3f(p) then
        if (nil == string.match(p, "%.%w+")) then
          local handle = vim.loop.fs_open(p, "w", 438)
          vim.loop.fs_close(handle)
        else
          vim.loop.fs_mkdir(p, 493)
        end
      end
      return p
    end
    v_0_0 = ensure0
    _0_0["ensure"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["ensure"] = v_0_
  ensure = v_0_
end
local cache_dir = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function cache_dir0()
      return ensure(((os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/conjure"))
    end
    v_0_0 = cache_dir0
    _0_0["cache-dir"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["cache-dir"] = v_0_
  cache_dir = v_0_
end
local not_nil_3f = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function not_nil_3f0(v)
      return (not a["nil?"](v) and ("userdata" ~= type(v)))
    end
    v_0_0 = not_nil_3f0
    _0_0["not-nil?"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["not-nil?"] = v_0_
  not_nil_3f = v_0_
end
local supported = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function supported0(ext)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return true
      else
        local _ = _2_0
        return error(("lspdocs: " .. ext .. " is not supported"))
      end
    end
    v_0_0 = supported0
    _0_0["supported"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["supported"] = v_0_
  supported = v_0_
end
return nil