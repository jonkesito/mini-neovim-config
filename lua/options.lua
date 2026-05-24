vim.cmd.colorscheme("moonfly")


vim.g.netrw_banner = 0

vim.g.deprecated_warnings = false

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- =====================================================================
-- COLORES PERSONALIZADOS PARA MINI.STATUSLINE
-- =====================================================================

-- 1. Colores para el Bloque del Modo Actual (Lado izquierdo)
-- Cambia dinámicamente según estés navegando o escribiendo código
vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal',  { fg = '#11111b', bg = '#89b4fa', bold = true }) -- Azul para modo Normal
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert',  { fg = '#11111b', bg = '#a6e3a1', bold = true }) -- Verde para modo Inserción
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual',  { fg = '#11111b', bg = '#f9e2af', bold = true }) -- Amarillo para modo Visual
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#11111b', bg = '#cdd6f4', bold = true }) -- Blanco para modo Comando

-- 2. Colores para el Bloque Central (Información del archivo y Git)
vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#cdd6f4', bg = '#1e1e2e' }) -- Nombre del archivo activo
vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo',  { fg = '#bac2de', bg = '#313244' }) -- Diagnósticos del LSP e info de Git

-- 3. Colores para el Bloque Derecho (Posición de la línea y porcentaje)
vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { fg = '#11111b', bg = '#eba0ac', bold = true }) -- Tipo de archivo / Codificación


