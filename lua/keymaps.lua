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

-- Crear un autocomando para archivos de Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        -- Si el programa 'black' existe en tu Arch Linux...
        if vim.fn.executable("black") == 1 then
            -- Mapeamos <Leader>f para que ejecute black de forma nativa e invisible
            vim.keymap.set("n", "<leader>f", "<CMD>%!black -q -<CR>", { buffer = true, silent = true, desc = "Formatear Python con Black" })
        end
    end,
})

-- Crear un autocomando exclusivo para desarrollo Web (TypeScript, JavaScript, etc.)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "javascript", "vue", "typescriptreact", "javascriptreact", "json", "html", "css" },
    callback = function()
        -- Verificar si Prettier está instalado globalmente en la computadora
        if vim.fn.executable("prettier") == 1 then
            -- Mapear <Leader>f para pasar todo el búfer (%!) a través de Prettier enviando el tipo de archivo (parser)
            vim.keymap.set("n", "<leader>f", function()
                -- Obtener la extensión actual del archivo para que Prettier aplique las reglas correctas
                local ft = vim.bo.filetype
                -- Traducir tipos de Neovim a Parsers oficiales de Prettier
                if ft == "typescript" or ft == "typescriptreact" then ft = "typescript" end
                if ft == "javascript" or ft == "javascriptreact" then ft = "babel" end
                
                -- Ejecutar el filtro Unix de forma silenciosa en Neovim
                vim.cmd([[%!prettier --stdin-filepath ]] .. vim.fn.expand("%"))
            end, { buffer = true, silent = true, desc = "Formatear con Prettier" })
        end
    end,
})



