local map = vim.api.nvim_buf_set_keymap
local opt = {
    noremap = true,
    silent = true,
}

map(0, "n", "<leader>rc", ":Glow<CR>", opt)
vim.opt_local.wrap = false
vim.opt_local.textwidth = 80
vim.opt_local.linebreak = true
