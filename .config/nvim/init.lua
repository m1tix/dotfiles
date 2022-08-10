--------------------------------------------------
-- Packer (Stolen from nvim-lua/kickstart.nvim) --
--------------------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- Package manager

    -------------------
    -- Colorschemes  --
    -------------------
    use("folke/tokyonight.nvim") -- Tokyo night
    use("marko-cerovac/material.nvim") -- material
    use({ -- rose-pine
        "rose-pine/neovim",
        as = "rose-pine",
        tag = "v1.*",
    })
    use("shaunsingh/nord.nvim") -- nord ported to nvim
    use("rebelot/kanagawa.nvim") -- kanagawa
    use("sainnhe/everforest") -- everforest
    use("Shatur/neovim-ayu") -- ayu
    use({ -- CATPPUCCIN!
        "catppuccin/nvim",
        as = "catppuccin",
    })
    -------------------
    -- Other plugins --
    -------------------
    use("elkowar/yuck.vim") -- .yuck highlighting
    use("tpope/vim-surround") -- brackets
    use("tpope/vim-fugitive") -- git
    use("tpope/vim-commentary") -- nice commenting (gc)
    use("kyazdani42/nvim-tree.lua") -- tree explorer
    use({ -- Bufferline
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })
    -- use("famiu/bufdelete.nvim") -- delete buffers
    use({ -- highlighting
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use({ -- lua statusbar
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use({ -- summary of errors
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    })
    use("lewis6991/impatient.nvim") --increase startuptime
    use({ -- Running code while in files
        "CRAG666/code_runner.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use("lukas-reineke/indent-blankline.nvim") -- nice indentline
    use("Pocco81/true-zen.nvim") -- focus mode
    use("folke/twilight.nvim") -- better focus mode
    use("folke/which-key.nvim") -- which key
    use({ "akinsho/toggleterm.nvim", tag = "v2.*" }) -- nice terminal
    use("gbprod/cutlass.nvim")
    -------------------
    -- Lsp           --
    -------------------
    use("neovim/nvim-lspconfig") -- autocomplete time!
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("jose-elias-alvarez/null-ls.nvim") -- linting/formatting
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")
    use("j-hui/fidget.nvim")
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    if is_bootstrap then
        require("packer").sync()
    end
end)

if is_bootstrap then
    print("==================================")
    print("    Plugins are being installed")
    print("    Wait until Packer completes,")
    print("       then restart nvim")
    print("==================================")
    return
end

require("impatient")

--------------------------------------------------
-- Vim options                                  --
--------------------------------------------------
vim.cmd("set clipboard+=unnamedplus")
vim.o.inccommand = "nosplit"
vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect"
vim.opt.autoindent = true

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.timeoutlen = 500

--------------------------------------------------
-- Colors                                       --
--------------------------------------------------
-- Cool other themes:
---- Tokyo night
---- rose-pine
---- everforest
---- kanagawa
vim.o.termguicolors = true

-- Start autocolor
vim.o.background = "dark"
vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup({
    highlight_overrides = {
        mocha = {
            NvimTreeNormal = { bg = "#1e1e2e" },
            NormalFloat = { bg = "#1e1e2e" },
            VertSplit = { fg = "#313244" },
            NvimTreeVertSplit = { fg = "#313244" },
        },
    },
})
vim.cmd("colorscheme catppuccin")
vim.cmd("hi EndOfBuffer guifg=#1E1E2E")
-- End autocolor

--------------------------------------------------
-- Statusbar                                    --
--------------------------------------------------
-- It's the default lualine setup since it seems neat ;)
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
    },
    inactive_sections = {},
    tabline = {},
    extensions = { "nvim-tree" },
})
vim.opt.laststatus = 3

--------------------------------------------------
-- treesitter                                   --
--------------------------------------------------
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "python" },
    auto_install = true,
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            -- TODO: I'm not sure on this one.
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
})
--------------------------------------------------
-- lspconfig                                    --
--------------------------------------------------

local on_attach = function(client, bufnr)
    -- Eyo this works, but think will be temporary
    if client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
    end
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]tion")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gr", require("telescope.builtin").lsp_references)
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Float diagnostic")
    nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev error")
    nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next error")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
    vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        -- Might need to change this to formatting-seq-sync or whatever
        vim.lsp.buf.format or vim.lsp.buf.formatting,
        { desc = "Format current buffer" }
    )
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { "sumneko_lua", "pyright", "bashls" }

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "single",
    },
})
-- some lsp settings
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

--------------------------------------------------
-- null-ls                                      --
--------------------------------------------------
local null_ls_status_k, null_ls = pcall(require, "null-ls")
if not null_ls_status_k then
    return
end
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    on_attach = on_attach,
    sources = {
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        formatting.isort,
        formatting.black,
        diagnostics.flake8.with({
            extra_args = { "--max-line-length=88", "--select=C,E,F,W,B,B950", "--extend-ignore=E203" },
        }),
    },
})
--------------------------------------------------
-- completion                                   --
--------------------------------------------------
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}), -- might want to fix this soon? idk
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
    },
})

--------------------------------------------------
-- Key bindings                                 --
--------------------------------------------------

-- Highlight on yank (copy). It will do a nice highlight blink of the thing you just copied.
vim.api.nvim_exec(
    [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
    false
)

--------------------------------------------------
-- Bufferline/barbar                            --
--------------------------------------------------
require("bufferline").setup({
    options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
    },
    -- i might need this later, dont like the black bar
    -- highlights = {
    --     fill = {
    --         guibg = '#232136',
    --     }
    -- },
})

--------------------------------------------------
-- code_runner                                  --
--------------------------------------------------
require("code_runner").setup({
    -- put here the commands by filetype
    filetype = {
        python = "python3 -u",
    },
})
--------------------------------------------------
-- nvim tree lua                                --
--------------------------------------------------
require("nvim-tree").setup()

--------------------------------------------------
-- indent blankline                             --
--------------------------------------------------
require("indent_blankline").setup({
    show_first_indent_level = false,
    char_blankline = " ",
})

--------------------------------------------------
-- truezen mode and twilight                    --
--------------------------------------------------
require("true-zen").setup({
    integrations = {
        lualine = true,
        twilight = false,
    },
})

require("twilight").setup()

--------------------------------------------------
-- fidget nvim                                  --
--------------------------------------------------
require("fidget").setup()

--------------------------------------------------
-- which-key                                    --
--------------------------------------------------
require("which-key").setup({
    window = {
        border = "single",
    },
})

--------------------------------------------------
-- toggleterm                                   --
--------------------------------------------------
require("toggleterm").setup({
    shade_terminals = false,
})
--------------------------------------------------
-- Keybindings                                  --
--------------------------------------------------

local map = vim.api.nvim_set_keymap
local opt = {
    noremap = true,
    silent = true,
}

-- Rebind all delete options to black hole register
require("cutlass").setup()
map("n", "b]", ":BufferLineCycleNext<CR>", opt)
map("n", "b[", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>bd", ":bdelete<CR>", opt)
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", opt)
map("n", "<leader>f", ":Format<CR>", opt)
map("n", "<leader>rr", ":RunFile<CR>", { noremap = true, silent = false })
map("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>zn", ":TZAtaraxis<CR>", opt)
map("n", "<leader>w", ":WhichKey<CR>", opt)
map("n", "<leader>t", ":ToggleTerm<CR>", opt)

-- Terminal mode
map("t", "<esc>", [[<C-\><C-n>]], opt)
