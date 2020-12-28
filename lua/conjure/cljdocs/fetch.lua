local _0_0 = nil
do
  local name_0_ = "conjure.cljdocs.fetch"
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
    return {require("conjure.aniseed.core"), require("conjure.aniseed.fennel"), require("conjure.aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", fennel = "conjure.aniseed.fennel", str = "conjure.aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local fennel = _local_0_[2]
local str = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.cljdocs.fetch"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local exists_3f = nil
do
  local v_0_ = nil
  local function exists_3f0(p)
    assert(("string" == type(p)), ("`exists` expected string got " .. type(p)))
    local stat = vim.loop.fs_stat(p)
    if stat then
      return stat.type
    else
      return false
    end
  end
  v_0_ = exists_3f0
  _0_0["aniseed/locals"]["exists?"] = v_0_
  exists_3f = v_0_
end
local ensure = nil
do
  local v_0_ = nil
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
  v_0_ = ensure0
  _0_0["aniseed/locals"]["ensure"] = v_0_
  ensure = v_0_
end
local cache_dir = nil
do
  local v_0_ = nil
  local function cache_dir0()
    return ensure(((os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/conjure"))
  end
  v_0_ = cache_dir0
  _0_0["aniseed/locals"]["cache-dir"] = v_0_
  cache_dir = v_0_
end
local url = nil
do
  local v_0_ = str.join({"https://gist.githubusercontent.com", "/tami5/", "14c0098691ce57b1c380c9c91dbdd322", "/raw/", "b859bd867115960bc72a49903e2b8de0ce249c31", "/clojure.docs.fnl"})
  _0_0["aniseed/locals"]["url"] = v_0_
  url = v_0_
end
local path = nil
do
  local v_0_ = (cache_dir() .. "/" .. "clj-docs.fnl")
  _0_0["aniseed/locals"]["path"] = v_0_
  path = v_0_
end
local download = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function download0(callback)
      local msg = "Downloading cljdocs.fnl to $XDG_CACHE_HOME/conjure/clj-docs.fnl ..."
      local err = "Couldn't download cljdocs.fnl, try again or report issue."
      local valid = nil
      local function _2_()
        return (exists_3f(path) and (vim.loop.fs_stat(path).size > 1700))
      end
      valid = _2_
      if valid() then
        return callback()
      else
        print(msg)
        local function _3_()
          if valid() then
            return callback()
          else
            return print(err)
          end
        end
        return vim.fn.jobstart({"curl", "-L", url, "-o", path}, {on_exit = _3_})
      end
    end
    v_0_0 = download0
    _0_0["download"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["download"] = v_0_
  download = v_0_
end
local update = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function update0(cb)
      local function _2_()
        return download(cb)
      end
      return vim.fn.jobstart({"rm", path}, {on_exit = _2_})
    end
    v_0_0 = update0
    _0_0["update"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["update"] = v_0_
  update = v_0_
end
local parse = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function parse0()
      return fennel.dofile(path)
    end
    v_0_0 = parse0
    _0_0["parse"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["parse"] = v_0_
  parse = v_0_
end
return nil