







local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep Project" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "List Buffers" })


local gs = require("gitsigns")
vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Git Change" })
vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Git Change" })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Change" })


