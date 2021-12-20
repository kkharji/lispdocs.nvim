local _0_0 = nil
do
  local name_0_ = "lispdocs.util"
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["exists?"] = v_0_
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["ensure"] = v_0_
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["cache-dir"] = v_0_
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["not-nil?"] = v_0_
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
      elseif (_2_0 == "cljc") then
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["supported"] = v_0_
  supported = v_0_
end
local get_ft = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get_ft0(ext)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return "clojure"
      elseif (_2_0 == "cljc") then
        return "clojure"
      else
        local _ = _2_0
        return error(("lspdocs.nvim: " .. (ext or "unknown!") .. " is not supported"))
      end
    end
    v_0_0 = get_ft0
    _0_0["get-ft"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-ft"] = v_0_
  get_ft = v_0_
end
local get_preview_ft = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get_preview_ft0(ext)
      return vim.g[("lispdocs_" .. (get_ft(ext) or "") .. "_preview_ft")]
    end
    v_0_0 = get_preview_ft0
    _0_0["get-preview-ft"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-preview-ft"] = v_0_
  get_preview_ft = v_0_
end
local get_docs_download_url = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get_docs_download_url0(ext)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return "https://clojuredocs.org/clojuredocs-export.json"
      elseif (_2_0 == "cljc") then
        return "https://clojuredocs.org/clojuredocs-export.json"
      end
    end
    v_0_0 = get_docs_download_url0
    _0_0["get-docs-download-url"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-docs-download-url"] = v_0_
  get_docs_download_url = v_0_
end
local get_docs_tmp_path = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get_docs_tmp_path0(ext)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return "/tmp/cljex.json"
      elseif (_2_0 == "cljc") then
        return "/tmp/cljex.json"
      end
    end
    v_0_0 = get_docs_tmp_path0
    _0_0["get-docs-tmp-path"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["get-docs-tmp-path"] = v_0_
  get_docs_tmp_path = v_0_
end
return nil