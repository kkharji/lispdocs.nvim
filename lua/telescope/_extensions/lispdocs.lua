local _0_0 = nil
do
  local name_0_ = "telescope.__extensions.lispdocs"
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
    return {require("telescope.actions"), require("telescope.config"), require("lispdocs.db"), require("telescope.pickers.entry_display"), require("telescope.finders"), require("plenary.filetype"), require("telescope.pickers"), require("telescope.previewers"), require("telescope.previewers.utils"), require("telescope.state"), require("telescope"), require("lispdocs.util"), require("telescope.utils")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {actions = "telescope.actions", conf = "telescope.config", db = "lispdocs.db", entry_display = "telescope.pickers.entry_display", finders = "telescope.finders", pft = "plenary.filetype", pickers = "telescope.pickers", previewers = "telescope.previewers", putils = "telescope.previewers.utils", state = "telescope.state", telescope = "telescope", util = "lispdocs.util", utils = "telescope.utils"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local actions = _local_0_[1]
local state = _local_0_[10]
local telescope = _local_0_[11]
local util = _local_0_[12]
local utils = _local_0_[13]
local conf = _local_0_[2]
local db = _local_0_[3]
local entry_display = _local_0_[4]
local finders = _local_0_[5]
local pft = _local_0_[6]
local pickers = _local_0_[7]
local previewers = _local_0_[8]
local putils = _local_0_[9]
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
  _0_0["aniseed/locals"]["make-display"] = v_0_
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
  _0_0["aniseed/locals"]["entry-maker"] = v_0_
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
        return putils.highlighter(self.state.bufnr, "markdown")
      end
    end
    local function _4_(_, entry)
      return entry.symbol
    end
    return previewers.new_buffer_previewer({define_preview = _3_, get_buffer_by_name = _4_, keep_last_buf = true})
  end
  v_0_ = utils.make_default_callable(_2_, {})
  _0_0["aniseed/locals"]["previewer"] = v_0_
  previewer = v_0_
end
local set_mappings = nil
do
  local v_0_ = nil
  local function set_mappings0(bufnr)
    local function _2_(_, cmd)
      actions.close(bufnr)
      local last_bufnr = state.get_global_key("last_preview_bufnr")
      local run = nil
      local function _3_(_241)
        return vim.cmd((_241 .. " " .. last_bufnr))
      end
      run = _3_
      local _4_0 = cmd
      if (_4_0 == "edit") then
        return run(":buffer")
      elseif (_4_0 == "new") then
        return run(":sbuffer")
      elseif (_4_0 == "vnew") then
        return run(":vert sbuffer")
      elseif (_4_0 == "tabedit") then
        return run(":tab sb")
      end
    end
    do end (actions._goto_file_selection):replace(_2_)
    return true
  end
  v_0_ = set_mappings0
  _0_0["aniseed/locals"]["set-mappings"] = v_0_
  set_mappings = v_0_
end
local lispdocs_find = nil
do
  local v_0_ = nil
  local function lispdocs_find0(opts)
    local config = {attach_mappings = set_mappings, finder = finders.new_table({entry_maker = entry_maker, results = (opts.tbl):get({keys = {"symbol", "preview"}})}), previewer = previewer.new(opts), prompt_title = "Lispdocs", sorter = conf.values.generic_sorter(opts)}
    return pickers.new(opts, config):find()
  end
  v_0_ = lispdocs_find0
  _0_0["aniseed/locals"]["lispdocs-find"] = v_0_
  lispdocs_find = v_0_
end
local function _2_(_241)
  local opts = (_241 or {})
  local ext = (opts.ext or "clj")
  opts["tbl"] = (db[ext] or {})
  if (util.supported(ext) and (opts.tbl):empty()) then
    local function _3_()
      return lispdocs_find(opts)
    end
    return (opts.tbl):seed(vim.schedule_wrap(_3_))
  else
    return lispdocs_find(opts)
  end
end
return telescope.register_extension({exports = {lispdocs = _2_}})