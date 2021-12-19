local _0_0 = nil
do
  local name_0_ = "telescope.__extensions.lispdocs"
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
    return {require("lispdocs.finder"), require("lispdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {finder = "lispdocs.finder", util = "lispdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local finder = _local_0_[1]
local util = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "telescope.__extensions.lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
return telescope.register_extension({exports = {lispdocs = finder.find}})