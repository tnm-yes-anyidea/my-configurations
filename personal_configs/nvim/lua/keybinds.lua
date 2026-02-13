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



local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep Project" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "List Buffers" })


local gs = require("gitsigns")
vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Git Change" })
vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Git Change" })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Change" })


