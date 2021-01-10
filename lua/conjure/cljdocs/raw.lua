local _0_0 = nil
do
  local name_0_ = "conjure.cljdocs.raw"
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
    return {require("conjure.aniseed.core"), require("conjure.cljdocs.parse"), require("conjure.aniseed.string"), require("conjure.cljdocs.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", parse = "conjure.cljdocs.parse", str = "conjure.aniseed.string", util = "conjure.cljdocs.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local parse = _local_0_[2]
local str = _local_0_[3]
local util = _local_0_[4]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.cljdocs.raw"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local url = nil
do
  local v_0_ = nil
  local function url0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return "https://clojuredocs.org/clojuredocs-export.json"
    end
  end
  v_0_ = url0
  _0_0["aniseed/locals"]["url"] = v_0_
  url = v_0_
end
local tmp_file = nil
do
  local v_0_ = nil
  local function tmp_file0(ext)
    local _2_0 = ext
    if (_2_0 == "clj") then
      return "/tmp/cljex.json"
    end
  end
  v_0_ = tmp_file0
  _0_0["aniseed/locals"]["tmp-file"] = v_0_
  tmp_file = v_0_
end
local dl_msg = nil
do
  local v_0_ = nil
  local function dl_msg0(ext)
    return str.join(" ", {"Caching Docs and Usage Examples for", ext, "....."})
  end
  v_0_ = dl_msg0
  _0_0["aniseed/locals"]["dl-msg"] = v_0_
  dl_msg = v_0_
end
local dl_err = nil
do
  local v_0_ = nil
  local function dl_err0(ext)
    return str.join(" ", {"Docs and Usage Examples for", ext, "Couldn't downloaded for processing,", "try again or report issue."})
  end
  v_0_ = dl_err0
  _0_0["aniseed/locals"]["dl-err"] = v_0_
  dl_err = v_0_
end
local dl_succ = nil
do
  local v_0_ = nil
  local function dl_succ0(ext)
    return str.join(" ", {"Docs and usage examples for", ext, "has been downloaded and about to get cached"})
  end
  v_0_ = dl_succ0
  _0_0["aniseed/locals"]["dl-succ"] = v_0_
  dl_succ = v_0_
end
local fix_datatypes = nil
do
  local v_0_ = nil
  local function fix_datatypes0(v)
    local list_string = nil
    local function _2_(v0)
      if ("table" == type(v0)) then
        return str.join("||00|| ", v0)
      else
        return v0
      end
    end
    list_string = _2_
    local boolean_int = nil
    local function _3_(v0)
      if ("boolean" == type(v0)) then
        if (v0 == true) then
          return 1
        else
          return 0
        end
      else
        return v0
      end
    end
    boolean_int = _3_
    local vimnil_nil = nil
    local function _4_(v0)
      if ("userdata" == type(v0)) then
        return nil
      else
        return v0
      end
    end
    vimnil_nil = _4_
    return vimnil_nil(boolean_int(list_string(v)))
  end
  v_0_ = fix_datatypes0
  _0_0["aniseed/locals"]["fix-datatypes"] = v_0_
  fix_datatypes = v_0_
end
local tmp_file_exists_3f = nil
do
  local v_0_ = nil
  local function tmp_file_exists_3f0(ext)
    local path = tmp_file(ext)
    return (util["exists?"](path) and (vim.loop.fs_stat(path).size > 1700))
  end
  v_0_ = tmp_file_exists_3f0
  _0_0["aniseed/locals"]["tmp-file-exists?"] = v_0_
  tmp_file_exists_3f = v_0_
end
local download_raw_data = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function download_raw_data0(ext)
      local downloaded = nil
      if not tmp_file_exists_3f(ext) then
        local function _2_()
          if tmp_file_exists_3f(ext) then
            downloaded = true
            return nil
          else
            downloaded = false
            return nil
          end
        end
        vim.fn.jobstart({"curl", "-L", url(ext), "-o", tmp_file(ext)}, {on_exit = _2_})
        local function _3_()
          return ((downloaded == true) or (downloaded == false))
        end
        vim.wait(100000, _3_)
      end
      assert(downloaded, dl_err(ext))
      return print(dl_succ(ext))
    end
    v_0_0 = download_raw_data0
    _0_0["download-raw-data"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["download-raw-data"] = v_0_
  download_raw_data = v_0_
end
local get_raw_json_data = nil
do
  local v_0_ = nil
  local function get_raw_json_data0(ext)
    local path = tmp_file(ext)
    local valid = tmp_file_exists_3f(ext)
    if not valid then
      print(dl_msg(ext))
      download_raw_data(path)
    end
    local file = io.open(path)
    local json = file:read("*all")
    file:close()
    return vim.fn.json_decode(json)
  end
  v_0_ = get_raw_json_data0
  _0_0["aniseed/locals"]["get-raw-json-data"] = v_0_
  get_raw_json_data = v_0_
end
local see_also_item = nil
do
  local v_0_ = nil
  local function see_also_item0(i)
    if util["not-nil?"](i) then
      local v = i["to-var"]
      if util["not-nil?"](v) then
        return (v.ns .. "/" .. v.name)
      else
        return ""
      end
    else
      return ""
    end
  end
  v_0_ = see_also_item0
  _0_0["aniseed/locals"]["see-also-item"] = v_0_
  see_also_item = v_0_
end
local see_alsos = nil
do
  local v_0_ = nil
  local function see_alsos0(i)
    local mapover = nil
    local function _2_(_241)
      if util["not-nil?"](_241) then
        local _3_0 = _241
        if _3_0 then
          return a.map(see_also_item, _3_0)
        else
          return _3_0
        end
      end
    end
    mapover = _2_
    return a.update(i, "see-alsos", mapover)
  end
  v_0_ = see_alsos0
  _0_0["aniseed/locals"]["see-alsos"] = v_0_
  see_alsos = v_0_
end
local get_body = nil
do
  local v_0_ = nil
  local function get_body0(i)
    if util["not-nil?"](i) then
      local _2_0 = i
      if _2_0 then
        local function _3_(_241)
          return _241.body
        end
        return a.map(_3_, _2_0)
      else
        return _2_0
      end
    end
  end
  v_0_ = get_body0
  _0_0["aniseed/locals"]["get-body"] = v_0_
  get_body = v_0_
end
local compact_clj_item = nil
do
  local v_0_ = nil
  local function compact_clj_item0(i)
    local notes = nil
    local function _2_(_241)
      return a.update(_241, "notes", get_body)
    end
    notes = _2_
    local examples = nil
    local function _3_(_241)
      return a.update(_241, "examples", get_body)
    end
    examples = _3_
    local item = a.assoc(i, "symbol", (i.ns .. "/" .. i.name))
    local _5_
    do
      local _4_0 = item
      if _4_0 then
        local _6_0 = see_alsos(_4_0)
        if _6_0 then
          local _8_0 = examples(_6_0)
          if _8_0 then
            _5_ = notes(_8_0)
          else
            _5_ = _8_0
          end
        else
          _5_ = _6_0
        end
      else
        _5_ = _4_0
      end
    end
    return a["select-keys"](_5_, {"arglists", "doc", "notes", "examples", "name", "ns", "see-alsos", "static", "type", "symbol"})
  end
  v_0_ = compact_clj_item0
  _0_0["aniseed/locals"]["compact-clj-item"] = v_0_
  compact_clj_item = v_0_
end
local format_clj_entry = nil
do
  local v_0_ = nil
  local function format_clj_entry0(item)
    local markdown = {preview = parse["parse-for"]("clj", item)}
    local res = {}
    a["merge!"](item, markdown)
    for k, v in pairs(item) do
      res[k:gsub("-", "_")] = fix_datatypes(v)
    end
    return res
  end
  v_0_ = format_clj_entry0
  _0_0["aniseed/locals"]["format-clj-entry"] = v_0_
  format_clj_entry = v_0_
end
local get_clj = nil
do
  local v_0_ = nil
  local function get_clj0()
    return a.map(format_clj_entry, a.map(compact_clj_item, get_raw_json_data("clj").vars))
  end
  v_0_ = get_clj0
  _0_0["aniseed/locals"]["get-clj"] = v_0_
  get_clj = v_0_
end
local get = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function get0(ext)
      local _2_0 = ext
      if (_2_0 == "clj") then
        return get_clj()
      end
    end
    v_0_0 = get0
    _0_0["get"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["get"] = v_0_
  get = v_0_
end
return nil