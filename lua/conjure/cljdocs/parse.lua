local _0_0 = nil
do
  local name_0_ = "conjure.cljdocs.parse"
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
local _2amodule_name_2a = "conjure.cljdocs.parse"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local markdown = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function markdown0(kv)
      local sec = {also = kv["see-alsos"], examples = kv.examples, header = {kv.ns, kv.name}, info = kv.doc, notes = kv.notes, signture = {kv.name, kv.arglists}}
      local formatlist = nil
      local function _2_(xs, title, template)
        local res = {}
        local count = 1
        if not a["empty?"](xs) then
          table.insert(res, title)
          table.insert(res, "--------------")
          local function _3_(item)
            table.insert(res, vim.split(string.format(template, count, str.trim(item)), "\n"))
            count = (count + 1)
            return nil
          end
          a["run!"](_3_, xs)
          return vim.tbl_flatten(res)
        end
      end
      formatlist = _2_
      local header = {string.format("%s/%s", unpack(sec.header)), "=============="}
      local signture = nil
      local function _3_(_241)
        return string.format("`(%s %s)`", a["get-in"](sec, {"signture", 1}), _241)
      end
      signture = {str.join(" ", a.map(_3_, a["get-in"](sec, {"signture", 2}))), " "}
      local info = {a.map(str.trim, vim.split(sec.info, "\n")), " "}
      local examples = formatlist(sec.examples, "Usage", "### Example %d:\n\n```clojure\n%s\n```\n--------------\n")
      local notes = formatlist(sec.notes, "Notes", "### Note %d:\n%s\n\n--------------\n")
      local see_also = nil
      if not a["empty?"](sec.also) then
        local function _4_(_241)
          return string.format("* `%s`", _241)
        end
        see_also = {"See Also", "--------------", a.map(_4_, sec.also), " "}
      else
      see_also = nil
      end
      return vim.tbl_flatten({header, signture, info, see_also, examples, notes})
    end
    v_0_0 = markdown0
    _0_0["markdown"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["markdown"] = v_0_
  markdown = v_0_
end
return nil