
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

--  --------------------------------------------------------
--
--  -----------------------------------------------------------------------
local dap = require('dap')
local dapui = require('dapui')

-- 1. Setup DAP-UI (No messy tables required!)
dapui.setup()

-- 2. Listeners (Auto-opens and closes the UI cleanly)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- 3. Language Configs (Untouched, exactly as you had them)
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function() return vim.fn.expand('%:p:r') end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}
dap.configurations.cpp = dap.configurations.c

dap.adapters.python = {
  type = 'executable',
  command = 'python', 
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function() return 'python' end,
  },
}

-- 4. Smart Keymaps (Your custom compile & run logic)
vim.keymap.set('n', '<F3>', function()
    local ft = vim.bo.filetype
    if ft == "c" or ft == "cpp" then
        local source = vim.fn.expand('%')
        local output = vim.fn.expand('%:p:r')
        local compiler = (ft == "c") and "gcc" or "g++"
        
        print("🔨 Compiling...")
        local exit_code = os.execute(string.format('%s -g "%s" -o "%s"', compiler, source, output))
        
        if exit_code ~= 0 then
            print("❌ Compilation Failed")
            return
        end
        print("✅ Success!")
    end
    dap.continue()
end, { desc = 'Build and Debug' })

vim.keymap.set('n', '<F8>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F12>', dap.step_into)
vim.keymap.set('n', '<S-F12>', dap.step_out)
vim.keymap.set('n', '<S-F3>', dap.terminate)

-- UI Specific Keymaps
vim.keymap.set('n', '<F4>', dapui.toggle, { desc = 'Toggle Debug UI' })

-- Replaced 'add_watch' with 'eval' for dapui. 
-- Hover over a variable and press F6 to see its value in a floating window!
vim.keymap.set('n', '<F6>', function() dapui.eval() end, { desc = 'Evaluate expression' })
-- -----------------------------------
--      5. Find files and etc
-- --------------------------------------------------------------

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
-- 1. Find Files with F1
vim.keymap.set("n", "<F1>", fzf.files, { desc = "Fzf Find Files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep Project" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "List Buffers" })

--  -----------------------------------
--      6.Git-signs nvim
-- -----------------------------------------------------------------------

local gs = require("gitsigns")
vim.keymap.set("n", "]nc", gs.next_hunk, { desc = "Next Git Change" })
vim.keymap.set("n", "[pc", gs.prev_hunk, { desc = "Prev Git Change" })
vim.keymap.set("n", "<leader>ph", gs.preview_hunk, { desc = "Preview Change" })
vim.keymap.set("n", '<F7>', gs.preview_hunk, { desc = "Preview Change" })

