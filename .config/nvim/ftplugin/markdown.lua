local map = vim.api.nvim_buf_set_keymap
local opt = {
    noremap = true,
    silent = true,
}

map(0, "n", "<leader>rc", ":Glow<CR>", opt)
