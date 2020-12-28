local _0_0 = nil
do
  local name_0_ = "conjure.clojuredocs"
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
    return {require("conjure.aniseed.core"), require("conjure.client"), require("conjure.clojuredocs.display"), require("conjure.eval"), require("conjure.clojuredocs.fetch"), require("conjure.aniseed.nvim"), require("conjure.clojuredocs.parse")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", client = "conjure.client", display = "conjure.clojuredocs.display", eval = "conjure.eval", fetch = "conjure.clojuredocs.fetch", nvim = "conjure.aniseed.nvim", parse = "conjure.clojuredocs.parse"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local client = _local_0_[2]
local display = _local_0_[3]
local eval = _local_0_[4]
local fetch = _local_0_[5]
local nvim = _local_0_[6]
local parse = _local_0_[7]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.clojuredocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local clojuredocs = nil
do
  local v_0_ = nil
  do
    local v_0_0 = (_0_0.clojuredocs or fetch.parse())
    _0_0["clojuredocs"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["clojuredocs"] = v_0_
  clojuredocs = v_0_
end
local get_symbol_ns = nil
do
  local v_0_ = nil
  local function get_symbol_ns0(cb, symbol)
    local function _2_(_241)
      return cb(clojuredocs[string.gsub(_241, "#'", "")])
    end
    return client["with-filetype"]("clojure", eval["eval-str"], {["on-result"] = _2_, ["passive?"] = true, code = string.format("(resolve '%s)", symbol), origin = "clojure"})
  end
  v_0_ = get_symbol_ns0
  _0_0["aniseed/locals"]["get-symbol-ns"] = v_0_
  get_symbol_ns = v_0_
end
local display_docs = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function display_docs0(opts)
      local symbol = (opts.symbol or vim.fn.expand("<cword>"))
      local function _2_(_241)
        local function _3_()
          if a["nil?"](_241) then
            return print(string.format("%s not found", symbol))
          else
            return a.assoc(opts, "content", parse.markdown(_241))
          end
        end
        return display.open(_3_())
      end
      return get_symbol_ns(_2_, symbol)
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