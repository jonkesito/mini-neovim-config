vim.g.mapleader = " "

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set("v", "<", "<gv", { desc = "unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "indent and keep selection" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without yanking" })
vim.keymap.set("i", "<c-c>", "<esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

-- Salir de modo inserción con jk o kj
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, nowait = true })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true, nowait = true })

-- Mover bloques de texto en modo visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

-- =====================================================================
-- SISTEMA DE FORMATEO BLINDADO (EVITA ALERTAS DE "NO MATCHING SERVERS")
-- =====================================================================

-- 1. 🐍 PYTHON: Usar Ruff de forma directa en el sistema
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        if vim.fn.executable("ruff") == 1 then
            vim.keymap.set("n", "<leader>f", "<CMD>write | silent !ruff check --select F401 --fix % | silent !ruff format % | edit!<CR>", { buffer = true, silent = true, desc = "Formatear con Ruff" })
        end
    end,
})

-- 2. 📦 WEB / VUE: Usar Prettier de forma directa en el sistema
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact", "json", "html", "css", "vue" },
    callback = function()
        if vim.fn.executable("prettier") == 1 then
            vim.keymap.set("n", "<leader>f", "<CMD>write | silent %!prettier --stdin-filepath %<CR>", { buffer = true, silent = true, desc = "Formatear con Prettier" })
        end
    end,
})

-- 3. 🌙 LUA: Forzar el formateo a través del cliente específico lua_ls
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.keymap.set("n", "<leader>f", function()
            -- Busca activamente si lua_ls está vivo en este archivo antes de disparar la acción
            local clients = vim.lsp.get_clients({ name = "lua_ls", bufnr = 0 })
            if #clients > 0 then
                vim.lsp.buf.format({ name = "lua_ls", async = true })
            else
                -- Si el LSP aún está cargando en segundo plano, usamos el formateador interno de Vim como plan B
                vim.cmd("normal! gg=G")
            end
        end, { buffer = true, silent = true, desc = "Formatear Lua de forma segura" })
    end,
})

