--------------------------------------------------
-- Package manager                              --
--------------------------------------------------
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

-- Setup plugins
-- PLUGINS NOT INSTALLED YET:
---- Colorschemes such as tokyonight, everforest, rose pine, material
---- Vista
---- Toggle term
require("lazy").setup({
    -----------------
    -- Colorscheme --
    -----------------
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    ----------------
    -- TS and LSP --
    ----------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",
    -- Lsp things
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim", -- nvim-lsp-installer replacement
    "williamboman/mason-lspconfig.nvim", -- integration with lspconfig
    "jose-elias-alvarez/null-ls.nvim", -- linting/formatting. Should be replaced
    "hrsh7th/nvim-cmp", -- completions
    -- Completion plugins
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    -- Funky icons
    "onsails/lspkind.nvim",
    -- Status
    "j-hui/fidget.nvim",
    -- Warning/error overview
    "folke/trouble.nvim",
    --------
    -- UI --
    --------
    "kyazdani42/nvim-tree.lua", -- filetree
    "nvim-lualine/lualine.nvim", -- lualine, no icons 'cause kinda finicky?
    { "akinsho/bufferline.nvim", version = "*", dependencies = "kyazdani42/nvim-web-devicons" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    "goolord/alpha-nvim", -- dashboard
    "stevearc/dressing.nvim", -- nice windows
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" }, -- folding time

    ----------
    -- Misc --
    ----------
    "windwp/nvim-autopairs", -- Autopair brackets etc
    { "abecodes/tabout.nvim", name = "tabout", dependencies = "nvim-treesitter/nvim-treesitter" },
    "numToStr/Comment.nvim",
    "folke/which-key.nvim", -- key map, goated plugin
    { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = "nvim-lua/plenary.nvim" }, -- teli
    { "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" }, -- code running
    "lervag/vimtex",
})
--------------------------------------------------
-- vim options                                  --
--------------------------------------------------
vim.cmd("set clipboard+=unnamedplus,unnamed")
-- vim.cmd([[let g:python3_host_prog = '/usr/bin/python3']])
vim.o.inccommand = "nosplit"
vim.o.hlsearch = true -- highlight searched object
vim.wo.number = true -- set numbers on the side
vim.wo.relativenumber = true -- set them relative to cursor
vim.o.hidden = true -- hidden buffers begone
vim.o.mouse = "a" -- some mouse support (can delete tbh, never use it)
vim.o.breakindent = true -- breakindent on line wrapping
vim.o.wrap = false -- wrap text long line; not sure....
vim.opt.undofile = true -- undofile
vim.wo.signcolumn = "yes:2" -- width of sign column
vim.o.completeopt = "menuone,noselect"
vim.opt.autoindent = true -- autoindent
vim.o.ignorecase = true -- ignore case while searching

vim.cmd([[
    augroup filetypedetect
    au! bufread,bufnewfile *.sage,*.spyx,*.pyx setfiletype python
    augroup end
]])

-- general tab settings
-- for specific filetypes, use ftplugin
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

-- which key setting
vim.opt.timeoutlen = 500

-- global options
local borderstyle = "rounded" -- borderstyle of all windows

--------------------------------------------------
-- Colors                                       --
--------------------------------------------------
-- Cool other themes:
-- aquarium-vim, rose-pine, catppuccin, everforest, iceberg
-- embark.vim, ayu, nightfox, kanagawa
vim.o.termguicolors = true

vim.o.background = "dark"
vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    highlight_overrides = {
        mocha = {
            NvimTreeNormal = { bg = colors.base },
            NormalFloat = { bg = colors.base },
            VertSplit = { fg = colors.surface0 },
            NvimTreeVertSplit = { fg = colors.surface0 },
            Folded = { bg = colors.base },
            -- recoloring of bufferline main frame color
            BufferLineIndicatorSelected = { fg = colors.mauve },
            BufferLineFill = { bg = colors.mantle },
            BufferLineSeparator = { fg = colors.mantle, bg = colors.mantle },
            -- nice current line highlight
            LineNr = { fg = colors.mauve },
            LineNrAbove = { fg = colors.surface1 },
            LineNrBelow = { fg = colors.surface1 },
        },
    },
    custom_highlights = {
        AlphaButtonText = { fg = colors.lavender, style = { "bold" } },
        AlphaButtonShortcut = { fg = colors.mauve, style = { "bold", "italic" } },
        AlphaHeader = { fg = colors.lavender, style = { "bold" } },
        AlphaFooter = { fg = colors.surface2, style = { "italic" } },
    },
})
vim.cmd("colorscheme catppuccin")
vim.cmd("hi EndOfBuffer guifg=#1E1E2E")

--------------------------------------------------
-- lspconfig                                    --
--------------------------------------------------

local on_attach = function(client, bufnr)
    -- disable formatting if multiple soures are active (null-ls vs lsp)
    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end
    -- enable formatting on save for go files.
    if client.name == "gopls" then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
    local nmap = function(keys, func, desc)
        -- if desc then
        --     desc = "LSP: " .. desc
        -- end
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
    nmap("<leader>fc", vim.lsp.buf.format, "[F]ormat [C]urrent buffer")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- enabled servers with mason
-- servers which are not installed via mason are not in this!
local servers = { "lua_ls", "texlab", "pyright" }

-- Mason config
require("mason-lspconfig").setup({
    -- this shit is bugged?
    -- ensure_installed = servers,
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

require("lspconfig").lua_ls.setup({
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
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})
require("lspconfig").gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
    init_options = {
        usePlaceholders = true,
    },
})
require("lspconfig").clangd.setup({
    init_options = {
        clangdFileStatus = true,
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").texlab.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        texlab = {
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Floating window setting for lsp
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
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
        -- Markdown, tex etc
        diagnostics.markdownlint,
        formatting.prettier.with({
            filetypes = { "markdown", "json" },
            diagnostic_config = {
                update_in_insert = false,
            },
        }),
        -- Python
        formatting.isort,
        formatting.yapf,
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

-- Autopairs and tabout
local npairs = require("nvim-autopairs")
npairs.setup()

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
        { open = "$", close = "$" },
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
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 25,
            preset = "codicons",
        }),
    },
})

--------------------------------------------------
-- LuaSnip                                      --
--------------------------------------------------
-- I dont like so many snippets tbh, just tex is enough ;)
-- also using c for a course, dont know enough syntax
require("luasnip.loaders.from_vscode").lazy_load({ include = { "tex", "c", "markdown", "python" } })

--------------------------------------------------
-- Dashboard                                    --
--------------------------------------------------
require("dressing").setup({})
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
    -- might edit this one to current directory, for now its fine though.
    button("f", "  > Find file", ":cd $HOME/Programming | Telescope find_files<CR>"),
    button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    button("s", "  > Settings", ":e $MYVIMRC<CR>"),
    button("u", "  > Update plugins", ":Lazy update<CR>"),
    button("q", "ﰌ  > Quit", ":qa<CR>"),
}
-- Footer: display version and total packages
local function footer()
    local total_plugins = require("lazy").stats().count
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
local lualine_vista = {
    sections = { lualine_a = {
        function()
            return vim.g.vista.provider
        end,
    } },
    filetypes = {
        "vista",
    },
}
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "│", right = "│" },
        section_separators = "",
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
    extensions = { "nvim-tree", "toggleterm", lualine_vista },
})
-- single line for all windows, dont think this is necessary since globalstatus is on
vim.opt.laststatus = 3

--------------------------------------------------
-- treesitter                                   --
--------------------------------------------------
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "python", "go" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = { "latex" },
    },
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
        disable = { "python", "latex" }, -- python indent still seems to suck
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
        -- this assumes we have a compile_flags.txt file!
        c = "cd $dir && gcc -o $fileNameWithoutExt $fileName @compile_flags.txt && $dir/$fileNameWithoutExt",
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
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})

--------------------------------------------------
-- fidget nvim                                  --
--------------------------------------------------
require("fidget").setup({
    notification = {
        window = {
            winblend = 100,
        },
    },
    progress = {
        suppress_on_insert = true, -- why the fuck is false default?
    },
})

--------------------------------------------------
-- which-key                                    --
--------------------------------------------------
require("which-key").setup({
    -- use global borderstyle
    presets = {
        operators = true,
    },
    window = {
        border = borderstyle,
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
})

--------------------------------------------------
-- Bufferline/barbar                            --
--------------------------------------------------
require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
        -- disable all icons (I dont use mouse)
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- change icons to better icons
        modified_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        -- Only show bufferline for 2+ buffers
        always_show_bufferline = false,
        -- If NvimTree is called, offet the bufferline
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
    },
})

--------------------------------------------------
-- Telescope (with its extensions)              --
--------------------------------------------------

require("telescope").setup({
    -- ignore packages from Go in workspace folders while searching
    -- not sure if this breaks some lsp functionality, who knows?
    defaults = {
        file_ignore_patterns = { "go/pkg/*" },
        initial_mode = "normal",
    },
    pickers = {
        lsp_document_symbols = {
            theme = "dropdown",
        },
        diagnostics = {
            theme = "dropdown",
        },
    },
})

--------------------------------------------------
-- Comments                                     --
--------------------------------------------------
require("Comment").setup()

--------------------------------------------------
-- Vimtex                                       --
--------------------------------------------------
vim.cmd([[let g:vimtex_quickfix_open_on_warning=0]])
vim.cmd([[let g:vimtex_syntax_enabled = 0]])
vim.cmd([[let g:vimtex_syntax_conceal_disable = 1]])

--------------------------------------------------
-- indent blankline                             --
--------------------------------------------------
-- require("indent_blankline").setup({
--     show_first_indent_level = false, -- dont show first indent
--     char_blankline = " ", -- remove blankline indent
-- })
local hooks = require("ibl.hooks")
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
require("ibl").setup({
    indent = {
        char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
    },
    scope = {
        show_start = false,
        show_end = false,
    },
})

--------------------------------------------------
-- Folding with Ufo                             --
--------------------------------------------------
-- folding symbols and othe
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- width of foldcolumn
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99 -- see ^
vim.o.foldenable = true -- enable fold of course
vim.opt.viewoptions = { "folds", "cursor" } -- remember folds/cursor on leave with mkview

require("ufo").setup({
    provider_selector = function(_, filetype, _)
        if filetype == "markdown" then
            return ""
        elseif filetype == "tex" then
            return { "lsp", "indent" }
        else
            return { "treesitter", "indent" }
        end
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

-- Bufferline bindings
map("n", "<leader>b]", ":BufferLineCycleNext<CR>", "[B]uffer next") -- next buffer
map("n", "<leader>b[", ":BufferLineCyclePrev<CR>", "[B]uffer prev]") -- previous buffer
map("n", "<leader>ob", ":BufferLinePick<CR>", "[O]pen [B]uffer") -- Open a currently opened buffer
map("n", "<leader>q", ":bdelete<CR>", "[Q]uit current buffer") -- delete current buffer

-- Trouble
map("n", "<leader>dd", ":TroubleToggle document_diagnostics<CR>", "[D]ocument [D]iagnostics")
map("n", "<leader>wd", ":TroubleToggle workspace_diagnostics<CR>", "[W]orkspace [D]iagnostics")

-- Tabout
map("i", "<A-l>", "<Plug>(TaboutMulti)", "Tabout next")
map("i", "<A-h>", "<Plug>(TaboutBackMulti)", "Tabout prev")

-- Snippets
map("i", "<C-l>", "<cmd>lua require'luasnip'.jump(1)<CR>", "Jump forwards in snippet")
map("s", "<C-l>", "<cmd>lua require'luasnip'.jump(1)<CR>", "Jump forwards in snippet")
map("i", "<C-h>", "<cmd>lua require'luasnip'.jump(-1)<CR>", "Jump backwards in snippet")
map("s", "<C-h>", "<cmd>lua require'luasnip'.jump(-1)<CR>", "Jump backwards in snippet")

-- Misc
map("n", "<C-n>", ":NvimTreeToggle<CR>", "Toggle NvimTree") -- toggle tree
map("n", "<leader>wk", ":WhichKey<CR>", "[W]hich[K]ey") -- whichkey
map("n", "<leader>ff", ":Telescope find_files<CR>", "[F]ind [F]iles") -- open fuzzy finding of files in current directory
map("n", "<leader>or", ":Telescope oldfiles<CR>", "[O]pen [R]ecent") -- fuzzy find in recent opened files
vim.api.nvim_set_keymap( -- run current file with code-runner
    "n",
    "<leader>rc",
    ":RunFile<CR>",
    { noremap = true, silent = false, desc = "[R]un [C]urrent file" }
)
