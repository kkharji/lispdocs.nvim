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
    return {require("telescope.actions"), require("telescope.actions.set"), require("telescope.config"), require("lispdocs.db"), require("telescope.pickers.entry_display"), require("telescope.finders"), require("plenary.filetype"), require("telescope.pickers"), require("telescope.previewers"), require("telescope.previewers.utils"), require("telescope.state"), require("telescope"), require("lispdocs.util"), require("telescope.utils")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {actions = "telescope.actions", actions_set = "telescope.actions.set", conf = "telescope.config", db = "lispdocs.db", entry_display = "telescope.pickers.entry_display", finders = "telescope.finders", pft = "plenary.filetype", pickers = "telescope.pickers", previewers = "telescope.previewers", putils = "telescope.previewers.utils", state = "telescope.state", telescope = "telescope", util = "lispdocs.util", utils = "telescope.utils"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local actions = _local_0_[1]
local putils = _local_0_[10]
local state = _local_0_[11]
local telescope = _local_0_[12]
local util = _local_0_[13]
local utils = _local_0_[14]
local actions_set = _local_0_[2]
local conf = _local_0_[3]
local db = _local_0_[4]
local entry_display = _local_0_[5]
local finders = _local_0_[6]
local pft = _local_0_[7]
local pickers = _local_0_[8]
local previewers = _local_0_[9]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "telescope.__extensions.lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local make_display = nil
do
  local v_0_ = nil
  local function make_display0(entry)
    local displayer = entry_display.create({hl_chars = {["|"] = "TelescopeResultsNumber"}, items = {{width = 30}, {remaining = true}, {remaining = true}}, separator = " "})
    return displayer({{entry.name, "TelescopeResultsNumber"}, {entry.ns, "TabLine"}})
  end
  v_0_ = make_display0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["make-display"] = v_0_
  make_display = v_0_
end
local entry_maker = nil
do
  local v_0_ = nil
  local function entry_maker0(entry)
    local _let_0_ = vim.split(entry.symbol, "/")
    local ns = _let_0_[1]
    local name = _let_0_[2]
    return {display = make_display, name = name, ns = ns, ordinal = (ns .. " " .. name), preview = entry.preview, symbol = entry.symbol, value = entry}
  end
  v_0_ = entry_maker0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["entry-maker"] = v_0_
  entry_maker = v_0_
end
local previewer = nil
do
  local v_0_ = nil
  local function _2_(opts)
    local function _3_(self, entry, status)
      if (entry.symbol ~= self.state.bufname) then
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(entry.preview, "||00||"))
        vim.api.nvim_win_set_option(self.state.preview_win, "wrap", true)
        return putils.highlighter(self.state.bufnr, (util["get-preview-ft"](opts.ext) or "markdown"))
      end
    end
    local function _4_(_, entry)
      return entry.symbol
    end
    return previewers.new_buffer_previewer({define_preview = _3_, get_buffer_by_name = _4_, keep_last_buf = true})
  end
  v_0_ = utils.make_default_callable(_2_, {})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["previewer"] = v_0_
  previewer = v_0_
end
local set_mappings = nil
do
  local v_0_ = nil
  local function set_mappings0(bufnr)
    local function _2_(_, direction)
      actions.close(bufnr)
      local last_bufnr = state.get_global_key("last_preview_bufnr")
      local cmd = nil
      do
        local _3_0 = direction
        if (_3_0 == "default") then
          cmd = ":buffer"
        elseif (_3_0 == "horizontal") then
          cmd = ":sbuffer"
        elseif (_3_0 == "vertical") then
          cmd = ":vert sbuffer"
        elseif (_3_0 == "tab") then
          cmd = ":tab sb"
        else
        cmd = nil
        end
      end
      return vim.cmd((cmd .. " " .. last_bufnr))
    end
    do end (actions_set.select):replace(_2_)
    return true
  end
  v_0_ = set_mappings0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["set-mappings"] = v_0_
  set_mappings = v_0_
end
local picker = nil
do
  local v_0_ = nil
  local function picker0(opts)
    local config = {attach_mappings = set_mappings, finder = finders.new_table({entry_maker = entry_maker, results = (opts.tbl):get({keys = {"symbol", "preview"}})}), previewer = previewer.new(opts), prompt_title = "Lispdocs", sorter = conf.values.generic_sorter(opts)}
    return pickers.new(opts, config):find()
  end
  v_0_ = picker0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["picker"] = v_0_
  picker = v_0_
end
local find = nil
do
  local v_0_ = nil
  local function find0(opts)
    local opts0 = (opts or {})
    opts0["ext"] = vim.fn.expand("%:e")
    opts0["tbl"] = (db[opts0.ext] or {})
    if (util.supported(opts0.ext) and (opts0.tbl):empty()) then
      local function _2_()
        return picker(opts0)
      end
      return (opts0.tbl):seed(vim.schedule_wrap(_2_))
    else
      return picker(opts0)
    end
  end
  v_0_ = find0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["find"] = v_0_
  find = v_0_
end
return {find = find}