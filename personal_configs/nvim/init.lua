vim.g.mapleader=" "

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
      require("tokyonight").setup({ style = "night" })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  "itchyny/lightline.vim",
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





  

-- 3. Language Runners (F5 Keymaps)
-- We use autocmds to ensure these only apply to the correct file types
local function map_run(ft, command)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = function()
            vim.keymap.set("n", "<F5>", ":w | " .. command .. "<CR>", { buffer = true, silent = false })
        end,
    })
end

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


-- 4. Debugging (F3)
-- Python Debugging with pudb3
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "<F3>", ":w | vertical terminal pudb3 %<CR>", { buffer = true })
    end,
})

-- C/C++ Debugging with Termdebug
function StartDebug()
    if vim.g.termdebugger_started == nil then
        vim.cmd("packadd termdebug") -- Ensure termdebug is loaded
        vim.cmd("Termdebug " .. vim.fn.expand("%:r"))
        vim.g.termdebugger_started = 1
    else
        vim.cmd("Continue")
    end
end

vim.keymap.set("n", "<F3>", ":lua StartDebug()<CR>", { silent = true })





require("keybinds")
