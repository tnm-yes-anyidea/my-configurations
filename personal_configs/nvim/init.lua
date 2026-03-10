vim.g.mapleader=" "

vim.opt.colorcolumn = "80"   

-- 1.lazyvim configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example: Add your plugins here
require("lazy").setup({
  "folke/which-key.nvim",
  {priority=1001,
   "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
 
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({ 
      style = "moon", -- "storm" is less black than "night", more vibrant than "moon"
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    })
    vim.cmd.colorscheme("tokyonight")
  end,
},

 "folke/tokyonight.nvim",
  "neoclide/coc.nvim",
  "lewis6991/gitsigns.nvim",
  "ibhagwan/fzf-lua",
   "mfussenegger/nvim-dap",
   "rcarriga/nvim-dap-ui",
   "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
    

  })

--they are saved in .local/share/nvim/lazy


-- 2. General Options (Replacements for 'set')
vim.cmd("syntax on")
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.history = 100
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.termguicolors = true -- Highly recommended for modern themes

vim.cmd("filetype on")
vim.cmd("filetype indent on")





  

-- 3. Language Runner

-- Updated helper to use a split terminal for interactivity
local function map_run(lang, cmd)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        callback = function()
            -- We wrap the command in :term to allow keyboard input
            local final_cmd = ":w | split | term " .. cmd .. "<CR>i"
            vim.keymap.set("n", "<F5>", final_cmd, { buffer = true, silent = true })
        end
    })
end

-- Your updated mappings
--
map_run("fortran", "!gfortran % -o %< && ./%<")
map_run("julia", "!julia %")
map_run("go", "go run %")
map_run("rust", "cargo run") -- Prefers cargo if in a project, or 'rustc % -o %< && ./%<'
map_run("lua", "lua %")
map_run("php", "php %")
map_run("ruby", "ruby %")
map_run("perl", "perl %")
map_run("python", "python3 %")
map_run("c", "gcc % -o %< && ./%<")
map_run("cpp", "g++ % -o %< && ./%<")
map_run("java", "javac % && java %:r && rm %:r.class")



require("keybinds")
-- Load the statusline module
require('statusline')
