
--  ----------------------------------------------
--      1.Scrolling the suggestion list 
--  ---------------------------------

--  <F11> is reserved for maximizing/minimizing

-- Scroll UP to move UP in the Coc List
vim.keymap.set("i", "<ScrollWheelUp>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#prev"](1)
  end
  return "<ScrollWheelUp>"
end, { expr = true, silent = true })

-- Scroll DOWN to move DOWN in the Coc List
vim.keymap.set("i", "<ScrollWheelDown>", function()
  if vim.fn["coc#pum#visible"]() == 1 then
    return vim.fn["coc#pum#next"](1)
  end
  return "<ScrollWheelDown>"
end, { expr = true, silent = true })

-- ------------------------------------
--      2.Debug using DAP and extra plugins
-- ----------------------------------------------------------------------

local dap = require('dap')
local dap_view=require('dap-view')

-- Start / Continue Debugging  (assigned to f3)
vim.keymap.set('n', '<F3>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })

-- Toggle Breakpoint (The "Stop Sign")
vim.keymap.set('n', '<F8>', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })

-- Step Over (Next line, don't enter functions)
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })

-- Step Into (Enter the function on current line)
vim.keymap.set('n', '<F12>', function() dap.step_into() end, { desc = 'Debug: Step Into' })

-- Step Out (Finish current function and go back to caller)
vim.keymap.set('n', '<S-F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })

-- Stop / Terminate Session
vim.keymap.set('n', '<S-F3>', function() dap.terminate() end, { desc = 'Debug: Stop' })

-- --------------------------------------------------------------------------
--      3. UI MANAGEMENT (Dap-view)
-- --------------------------------------------------------------------------

local dap_view = require("dap-view")

-- Toggle UI manually (Like the Debug sidebar)
vim.keymap.set('n', '<F4>', function() dap_view.toggle() end, { desc = 'Debug: Toggle UI' })

-- Optional: Watch current expression/variable
vim.keymap.set('n', '<F6>', function() dap_view.add_watch() end, { desc = 'Debug: Add Watch' })
-- -----------------------------------
--      4. Find files and etc
-- --------------------------------------------------------------

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
-- 1. Find Files with F1
vim.keymap.set("n", "<F1>", fzf.files, { desc = "Fzf Find Files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep Project" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "List Buffers" })

--  -----------------------------------
--      5.Git-signs nvim
-- -----------------------------------------------------------------------

local gs = require("gitsigns")
vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Git Change" })
vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Git Change" })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Change" })
vim.keymap.set("n", '<F7>', gs.preview_hunk, { desc = "Preview Change" })

