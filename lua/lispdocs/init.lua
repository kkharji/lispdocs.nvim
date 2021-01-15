local _0_0 = nil
do
  local name_0_ = "lispdocs"
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
    return {require("conjure.aniseed.core"), require("conjure.client"), require("lispdocs.db"), require("lispdocs.display"), require("conjure.eval"), require("conjure.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", client = "conjure.client", db = "lispdocs.db", display = "lispdocs.display", eval = "conjure.eval", nvim = "conjure.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local client = _local_0_[2]
local db = _local_0_[3]
local display = _local_0_[4]
local eval = _local_0_[5]
local nvim = _local_0_[6]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local get_origin = nil
do
  local v_0_ = nil
  local function get_origin0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return "clojure"
    else
      local _ = _2_0
      return error(("lspdocs: " .. vim.fn.expand("%:e") .. " is not supported"))
    end
  end
  v_0_ = get_origin0
  _0_0["aniseed/locals"]["get-origin"] = v_0_
  get_origin = v_0_
end
local reslove_symbol = nil
do
  local v_0_ = nil
  local function reslove_symbol0(cb, ext, symbol)
    local function _2_(_241)
      return cb(db.preview(ext, string.gsub(_241, "#'", "")))
    end
    return client["with-filetype"](get_origin(ext), eval["eval-str"], {["on-result"] = _2_, ["passive?"] = true, code = string.format("(resolve '%s)", symbol), origin = get_origin(ext)})
  end
  v_0_ = reslove_symbol0
  _0_0["aniseed/locals"]["reslove-symbol"] = v_0_
  reslove_symbol = v_0_
end
local display_docs = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function display_docs0(opts)
      local symbol = (opts.symbol or vim.fn.expand("<cword>"))
      local ext = vim.fn.expand("%:e")
      local function _2_(_241)
        local function _3_()
          if a["empty?"](_241) then
            return print(string.format("lspdocs.nvim: %s not found", symbol))
          else
            return a.assoc(opts, "content", _241)
          end
        end
        return display.open(_3_())
      end
      return reslove_symbol(_2_, ext, symbol)
    end
    v_0_0 = display_docs0
    _0_0["display-docs"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["display-docs"] = v_0_
  display_docs = v_0_
end
local float = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function float0(opts)
      return display_docs(a.merge({display = "float"}, opts))
    end
    v_0_0 = float0
    _0_0["float"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["float"] = v_0_
  float = v_0_
end
local vsplit = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function vsplit0(opts)
      return display_docs(a.merge({display = "vsplit"}, opts))
    end
    v_0_0 = vsplit0
    _0_0["vsplit"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["vsplit"] = v_0_
  vsplit = v_0_
end
local split = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function split0(opts)
      return display_docs(a.merge({display = "split"}), opts)
    end
    v_0_0 = split0
    _0_0["split"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["split"] = v_0_
  split = v_0_
end
return nil