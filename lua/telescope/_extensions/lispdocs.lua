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
    return {require("telescope.config"), require("lispdocs.db"), require("telescope.pickers.entry_display"), require("telescope.finders"), require("plenary.filetype"), require("telescope.pickers"), require("telescope.previewers"), require("telescope.previewers.utils"), require("telescope"), require("telescope.utils")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {conf = "telescope.config", db = "lispdocs.db", entry_display = "telescope.pickers.entry_display", finders = "telescope.finders", pft = "plenary.filetype", pickers = "telescope.pickers", previewers = "telescope.previewers", putils = "telescope.previewers.utils", telescope = "telescope", utils = "telescope.utils"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local conf = _local_0_[1]
local utils = _local_0_[10]
local db = _local_0_[2]
local entry_display = _local_0_[3]
local finders = _local_0_[4]
local pft = _local_0_[5]
local pickers = _local_0_[6]
local previewers = _local_0_[7]
local putils = _local_0_[8]
local telescope = _local_0_[9]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "telescope.__extensions.lispdocs"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local defaulter = nil
do
  local v_0_ = utils.make_default_callable
  _0_0["aniseed/locals"]["defaulter"] = v_0_
  defaulter = v_0_
end
local make_display = nil
do
  local v_0_ = nil
  local function make_display0(entry)
    local displayer = entry_display.create({hl_chars = {["|"] = "TelescopeResultsNumber"}, items = {{width = 30}, {remaining = true}, {remaining = true}}, separator = " "})
    return displayer({{entry.name, "TelescopeResultsNumber"}, {entry.ns, "TabLine"}, {("(" .. entry.type .. ")"), "TabLine"}})
  end
  v_0_ = make_display0
  _0_0["aniseed/locals"]["make-display"] = v_0_
  make_display = v_0_
end
local entry_maker = nil
do
  local v_0_ = nil
  local function entry_maker0(entry)
    return {display = make_display, name = entry.name, ns = entry.ns, ordinal = (entry.ns .. " " .. entry.name .. " " .. entry.type), symbol = (entry.ns .. "/" .. entry.name), type = entry.type, value = entry}
  end
  v_0_ = entry_maker0
  _0_0["aniseed/locals"]["entry-maker"] = v_0_
  entry_maker = v_0_
end
local set_lines = nil
do
  local v_0_ = nil
  local function set_lines0(bufnr, ext, symbol)
    return vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, db.preview(ext, symbol))
  end
  v_0_ = set_lines0
  _0_0["aniseed/locals"]["set-lines"] = v_0_
  set_lines = v_0_
end
local previewer = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function _2_(opts)
      local function _3_(self, entry, status)
        if (entry.symbol ~= self.state.bufname) then
          set_lines(self.state.bufnr, opts.ext, entry.symbol)
          vim.api.nvim_win_set_option(self.state.preview_win, "wrap", true)
          return putils.highlighter(self.state.bufnr, "markdown")
        end
      end
      local function _4_(_, entry)
        return entry.symbol
      end
      return previewers.new_buffer_previewer({define_preview = _3_, get_buffer_by_name = _4_, keep_last_buf = true})
    end
    v_0_0 = defaulter(_2_, {})
    _0_0["previewer"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["previewer"] = v_0_
  previewer = v_0_
end
local lispdocs_find = nil
do
  local v_0_ = nil
  local function lispdocs_find0(opts)
    local opts0 = (opts or {})
    opts0["ext"] = (opts0.ext or "clj")
    local config = nil
    local function _2_(entry)
      return {display = make_display, ext = opts0.ext, name = entry.name, ns = entry.ns, ordinal = (entry.ns .. " " .. entry.name .. " " .. entry.type), symbol = (entry.ns .. "/" .. entry.name), type = entry.type, value = entry}
    end
    config = {finder = finders.new_table({entry_maker = _2_, results = db.all(opts0.ext)}), previewer = previewer.new(opts0), prompt_title = "Lispdocs", sorter = conf.values.generic_sorter(opts0)}
    return pickers.new(opts0, config):find()
  end
  v_0_ = lispdocs_find0
  _0_0["aniseed/locals"]["lispdocs-find"] = v_0_
  lispdocs_find = v_0_
end
return telescope.register_extension({exports = {lispdocs = lispdocs_find}})