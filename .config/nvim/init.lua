-- SOME INFO:
-- DO NOT update neovim automatically before PR #17446,
-- instead: edit src/nvim/screen.c around line 1931.
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

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Let packer use a float for its information popups
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Setup plugins
packer.startup(function(use)
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
    use("EdenEast/nightfox.nvim")
    use({ -- CATPPUCCIN!
        "catppuccin/nvim",
        as = "catppuccin",
    })
    -------------------
    -- Other plugins --
    -------------------
    use("elkowar/yuck.vim") -- .yuck highlighting
    -- Might need to add some neovim variants of these, but atm not missing them
    -- surround seems quite interesting tho
    -- use("tpope/vim-surround") -- brackets
    -- use("tpope/vim-fugitive") -- git
    use("numToStr/Comment.nvim") -- easy commenting with gc/gcc
    use("kyazdani42/nvim-tree.lua") -- tree explorer
    use({ -- Bufferline
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })
    use({ -- highlighting/indentation etc (GOAT plugin)
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
    use("folke/which-key.nvim") -- which key
    use({ "akinsho/toggleterm.nvim", tag = "v2.*" }) -- nice terminal
    use("gbprod/cutlass.nvim") -- overwrite neovim copy yoinks etc
    use("ellisonleao/glow.nvim") -- markdown render inside neovim
    use("dstein64/vim-startuptime") -- timing
    use({ -- improved folding (also edited screen.c in source code for better folds)
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
    })
    use("goolord/alpha-nvim") -- dashboard?
    use("windwp/nvim-autopairs") -- trying out autopairs again...
    use({
        "abecodes/tabout.nvim",
        as = "tabout",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    -------------------
    -- Lsp/complete  --
    -------------------
    use("neovim/nvim-lspconfig") -- its lsp time
    use("williamboman/mason.nvim") -- nvim-lsp-installer replacement
    use("williamboman/mason-lspconfig.nvim") -- better integration mason with lspconfig
    use("jose-elias-alvarez/null-ls.nvim") -- linting/formatting
    use("hrsh7th/nvim-cmp") -- its completion time
    -- Completion plugins
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lua")
    -- Snippets!
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    -- Other lsp things
    use("onsails/lspkind.nvim") -- some icons
    use("j-hui/fidget.nvim") -- status of lsp
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
-- Testing whether packer_installed works now
vim.cmd("source $HOME/.config/nvim/plugin/packer_compiled.lua")
vim.cmd("set clipboard+=unnamedplus")
vim.o.inccommand = "nosplit"
vim.o.hlsearch = true -- highlight searched object
vim.wo.number = true -- set numbers on the side
vim.wo.relativenumber = true -- set them relative to cursor
vim.o.hidden = true -- hidden buffers begone
vim.o.mouse = "a" -- some mouse support (can delete tbh, never use it)
vim.o.breakindent = true -- breakindent on line wrapping
vim.opt.undofile = true -- undofile
vim.wo.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect"
vim.opt.autoindent = true -- autoindent
vim.o.ignorecase = true

-- General tab settings
-- For specific filetypes, use ftplugin
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

-- Which key setting
vim.opt.timeoutlen = 500

-- Global options
local borderstyle = "rounded" -- borderstyle of all windows

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
local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
    highlight_overrides = {
        mocha = {
            NvimTreeNormal = { bg = colors.base },
            NormalFloat = { bg = colors.base },
            VertSplit = { fg = colors.surface0 },
            NvimTreeVertSplit = { fg = colors.surface0 },
            Folded = { bg = colors.base },
            BufferLineIndicatorSelected = { fg = colors.mauve },
            BufferLineFill = { bg = colors.mantle },
        },
    },
    custom_highlights = {
        AlphaButtonText = { fg = colors.lavender, style = { "bold" } },
        AlphaButtonShortcut = { fg = colors.rosewater, style = { "bold", "italic" } },
        AlphaHeader = { fg = colors.lavender, style = { "bold" } },
        AlphaFooter = { fg = colors.surface2, style = { "italic" } },
    },
})
vim.cmd("colorscheme catppuccin")
vim.cmd("hi EndOfBuffer guifg=#1E1E2E")
-- End autocolor

--------------------------------------------------
-- Dashboard                                    --
--------------------------------------------------
-- Yoinked from one of the config files listed in github discussion
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
-- Header
-- shoutout to my dog toby <3
dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣠⣶⠚⠛⠿⠷⠶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⢀⣴⠟⠉⠀⠀⢠⡄⠀⠀⠀⠀⠀⠉⠙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⢀⡴⠛⠁⠀⠀⠀⠀⠘⣷⣴⠏⠀⠀⣠⡄⠀⠀⢨⡇⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠺⣇⠀⠀⠀⠀⠀⠀⠀⠘⣿⠀⠀⠘⣻⣻⡆⠀⠀⠙⠦⣄⣀⠀⠀⠀⠀",
    "⠀⠀⠀⢰⡟⢷⡄⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢻⠶⢤⡀",
    "⠀⠀⠀⣾⣇⠀⠻⣄⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⣴⣿",
    "⠀⠀⢸⡟⠻⣆⠀⠈⠳⢄⡀⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⠶⢤⣬⡿⠁",
    "⠀⢀⣿⠃⠀⠹⣆⠀⠀⠀⠙⠓⠿⢧⡀⠀⢠⡴⣶⣶⣒⣋⣀⣀⣤⣶⣶⠟⠁⠀",
    "⠀⣼⡏⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠙⠳⠶⠤⠵⣶⠒⠚⠻⠿⠋⠁⠀⠀⠀⠀",
    "⢰⣿⡇⠀⠀⠀⠀⠀⠀⠀⣆⠀⠀⠀⠀⠀⠀⠀⢠⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⢿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠘⣦⡀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣷⡄⠀⠀⠀⠀⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⢸⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀",
}
dashboard.section.header.opts.hl = "AlphaHeader"

-- Buttons of dashboard
local function button(sc, txt, keybind, keybind_opts)
    local db = dashboard.button(sc, txt, keybind, keybind_opts)
    db.opts.hl = "AlphaButtonText"
    db.opts.hl_shortcut = "AlphaButtonShortcut"
    db.opts.width = 33
    db.opts.cursor = 5
    return db
end
dashboard.section.buttons.val = {
    button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    button("f", "  > Find file", ":cd $HOME/Programming | Telescope find_files<CR>"),
    button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    button("s", "  > Settings", ":e $MYVIMRC<CR>"),
    button("u", "  > Update plugins", ":PackerSync<CR>"),
    button("q", "ﰌ  > Quit", ":qa<CR>"),
}
-- Footer: display version and total packages
local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    -- Kinda wanna use nvim --version | head -1, but cant figure it out
    local version = vim.version()
    local nvim_version = "  Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return " " .. total_plugins .. " plugins" .. nvim_version
end
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "AlphaFooter"
-- Spacing and layout of dashboard
dashboard.section.buttons.opts.spacing = 0
dashboard.config.layout = {
    { type = "padding", val = 1 },
    dashboard.section.header,
    { type = "padding", val = 1 },
    dashboard.section.buttons,
    { type = "padding", val = 0 },
    dashboard.section.footer,
}
alpha.setup(dashboard.opts)
--------------------------------------------------
-- Statusbar                                    --
--------------------------------------------------
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "packer" },
        always_divide_middle = true,
        globalstatus = true, -- single line for all windows
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
    },
    inactive_sections = {},
    tabline = {},
    extensions = { "nvim-tree", "toggleterm" },
})
vim.opt.laststatus = 3 -- single line for all windows, dont think this is necessary since globalstatus is on

--------------------------------------------------
-- treesitter                                   --
--------------------------------------------------
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "python", "go" },
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
    indent = {
        enable = true,
        disable = { "python" }, -- python indent still seems to suck
    },
})

--------------------------------------------------
-- Telescope                                    --
--------------------------------------------------
require("telescope").setup({
    -- ignore packages from Go in workspace folders while searching
    -- not sure if this breaks some lsp functionality, who knows?
    defaults = {
        file_ignore_patterns = { "Go/pkg/*" },
    },
    pickers = {
        lsp_document_symbols = {
            theme = "dropdown",
        },
    },
})
--------------------------------------------------
-- lspconfig                                    --
--------------------------------------------------

local on_attach = function(client, bufnr)
    -- Eyo this works, but think will be temporary
    if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
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
    nmap("<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "[W]orkspace [L]ist")
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

-- enabled servers
local servers = { "sumneko_lua", "pyright", "bashls", "gopls" }

-- Mason config
require("mason-lspconfig").setup({
    ensure_installed = servers,
})
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = borderstyle,
    },
})

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

-- ensure servers are enabled on buffer start
for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- some specific lsp settings
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

require("lspconfig").gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
        },
    },
})

-- Floating window setting for lsp
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = borderstyle,
        source = "always",
        header = "",
        prefix = "",
    },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = borderstyle })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = borderstyle })

--------------------------------------------------
-- null-ls                                      --
--------------------------------------------------
local null_ls_status_k, null_ls = pcall(require, "null-ls")
if not null_ls_status_k then
    return
end
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local code_action = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    on_attach = on_attach,
    sources = {
        -- Lua
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        -- Python
        formatting.isort,
        formatting.black,
        diagnostics.flake8.with({
            extra_args = { "--max-line-length=88", "--select=C,E,F,W,B,B950", "--extend-ignore=E203" },
        }),
        -- Markdown, tex etc
        diagnostics.markdownlint,
        formatting.prettier.with({
            filetypes = { "markdown" },
        }),
        -- Go
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
local lspkind = require("lspkind")

-- Autopairs and tabout
require("nvim-autopairs").setup()
require("tabout").setup({
    tabkey = "<C-k>",
    backwards_tabkey = "<C-j>",
    act_as_tab = false,
    act_as_shift_tab = false,
    completion = false,
    enable_backwards = false,
    tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
    },
})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- scroll down completion window
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll up completion window
        ["<C-Space>"] = cmp.mapping.complete({}), -- manually query completion
        ["<CR>"] = cmp.mapping.confirm({ -- complete selected item
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback) -- tab settings for snippets and completion
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- same as above but reversed
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    -- Sources
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        { name = "nvim_lua" },
    },
    -- Use symbols as formatting in completion window
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
        }),
    },
})

--------------------------------------------------
-- LuaSnip                                      --
--------------------------------------------------
-- I dont like so many snippets tbh
-- require("luasnip.loaders.from_vscode").lazy_load()
--------------------------------------------------
-- Bufferline/barbar                            --
--------------------------------------------------
require("bufferline").setup({
    options = {
        -- disable all icons (I dont use mouse)
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- Only show bufferline for 2+ buffers
        always_show_bufferline = false,
        -- If NvimTree is called, offet the bufferline
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
    },
})

--------------------------------------------------
-- code_runner                                  --
--------------------------------------------------
require("code_runner").setup({
    -- let code be ran in floating window
    mode = "float",
    -- add "<filetype> = <command>" here for code_runner to be enabled in said filetype
    filetype = {
        python = "python3 -u",
        go = "go run",
    },
    -- use global border for the floating window
    float = {
        border = borderstyle,
    },
})
--------------------------------------------------
-- nvim tree lua                                --
--------------------------------------------------
require("nvim-tree").setup({
    -- dont show git
    renderer = {
        icons = {
            show = {
                git = false,
            },
        },
    },
})

--------------------------------------------------
-- indent blankline                             --
--------------------------------------------------
require("indent_blankline").setup({
    show_first_indent_level = false, -- dont show first indent
    char_blankline = " ", -- remove blankline indent
})

--------------------------------------------------
-- truezen mode                                 --
--------------------------------------------------
require("true-zen").setup({
    integrations = {
        lualine = true,
        twilight = false,
    },
})

--------------------------------------------------
-- fidget nvim                                  --
--------------------------------------------------
require("fidget").setup()

--------------------------------------------------
-- which-key                                    --
--------------------------------------------------
require("which-key").setup({
    -- use global borderstyle
    window = {
        border = borderstyle,
    },
})

--------------------------------------------------
-- toggleterm                                   --
--------------------------------------------------
require("toggleterm").setup({
    -- use regular background
    shade_terminals = false,
})
--------------------------------------------------
-- Glow (markdown inside neovim)                --
--------------------------------------------------
require("glow").setup({
    -- global border
    border = borderstyle,
})

--------------------------------------------------
-- Comments                                     --
--------------------------------------------------
require("Comment").setup()

--------------------------------------------------
-- Folding with Ufo                             --
--------------------------------------------------
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] -- folding symbols
vim.o.foldcolumn = "1" -- width of foldcolumn
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99 -- see ^
vim.o.foldenable = true -- enable fold of course
vim.opt.viewoptions = { "folds", "cursor" } -- remember folds/cursor on leave with mkview

require("ufo").setup({
    provider_selector = function(_, filetype, _)
        if filetype == "markdown" then
            return ""
        end
        return { "treesitter", "indent" }
    end,
})

--------------------------------------------------
-- Keybindings                                  --
--------------------------------------------------
-- Create aliases for ease of access
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
-- General mapping variable, as these opts are ubiquitous
local map = function(mode, keys, func, desc)
    local opt = {
        noremap = true,
        silent = true,
        desc = desc,
    }
    vim.api.nvim_set_keymap(mode, keys, func, opt)
end
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

-- Overwrite default fold bindings
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- Save folds on leave and apply them upon enter
-- Needs viewoptions set to at least folds
local saveAndLoadViews = create_augroup("saveAndLoadViews", { clear = true })
create_autocmd("BufWinLeave", {
    pattern = "*.*",
    command = "mkview",
    group = saveAndLoadViews,
    desc = "Save view on leaving buffer",
})
create_autocmd("BufWinEnter", {
    pattern = "*.*",
    command = "silent! loadview",
    group = saveAndLoadViews,
    desc = "Load view on entering buffer",
})

-- Rebind all delete options to black hole register
require("cutlass").setup()

map("n", "b]", ":BufferLineCycleNext<CR>", "Next buffer") -- next buffer
map("n", "b[", ":BufferLineCyclePrev<CR>", "Prev buffer") -- previous buffer
map("n", "<leader>q", ":bdelete<CR>", "[Q]uit current buffer") -- delete current buffer
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", "Toggle Trouble") -- toggle overview of lsp errors/warnings
map("n", "<leader>fc", ":Format<CR>", "[F]ormat [C]urrent buffer") -- format current file with lsp/null-ls
vim.api.nvim_set_keymap("n", "<leader>rr", ":RunFile<CR>", { noremap = true, silent = false, desc = "[R]un [R]egister" }) -- run file with code_runner
map("n", "<C-p>", ":NvimTreeToggle<CR>", "Toggle NvimTree") -- toggle tree
map("n", "<leader>zn", ":TZAtaraxis<CR>", "Toggle [Z]e[n]") -- toggle zen mode
map("n", "<leader>t", ":ToggleTerm<CR>", "Toggle [T]erminal") -- toggle built-in terminal
map("n", "<leader>wk", ":WhichKey<CR>", "[W]hich[K]ey") -- whichkey
map("t", "<esc>", [[<C-\><C-n>]], "Switch to normal mode") -- bind esc to normal mode in terminal mode
map("n", "<leader>ff", ":Telescope find_files<CR>", "[F]ind [F]iles") -- open fuzzy finding of files in current directory

-- Some tabout keybinding
map("i", "<A-k>", "<Plug>(TaboutMulti)", "Tabout next")
map("i", "<A-j>", "<Plug>(TaboutBackMulti)", "Tabout prev")
-- Jump in-and-out of snippets
map("i", "<C-l>", "<cmd>lua require'luasnip'.jump(1)<CR>", "Jump forwards in snippet")
map("s", "<C-l>", "<cmd>lua require'luasnip'.jump(1)<CR>", "Jump forwards in snippet")
map("i", "<C-h>", "<cmd>lua require'luasnip'.jump(-1)<CR>", "Jump backwards in snippet")
map("s", "<C-h>", "<cmd>lua require'luasnip'.jump(-1)<CR>", "Jump backwards in snippet")
