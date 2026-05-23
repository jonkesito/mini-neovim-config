-- =====================================================================
-- CONFIGURACIÓN DE LSP AVANZADA - AL ESTILO SIN-CY / NVIM-SCRATCH
-- =====================================================================
local lsp = {}

-- 1. Automatización de atajos cuando el LSP se conecta a un archivo
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local opts = { buffer = buf, silent = true }

        -- [Navegación de Código]
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- Ir a Definición
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)     -- Ir a Declaración
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- Ir a Implementación
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)      -- Buscar dónde se usa (Referencias)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)            -- Documentación flotante (Hover)

        -- [Acciones y Refactorización]
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)      -- Renombrar variables globalmente
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- Acciones de código (Fijar errores rápidos)

        -- [Diagnósticos / Errores]
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Ver error actual flotante
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)         -- Saltar al error anterior
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)         -- Saltar al siguiente error

        -- [Formateo de código automático]
        -- Si el servidor soporta formateo, presiona <Leader>f para ordenar tu código
        if client and client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end
    end,
})

-- 2. Integrar las capacidades de autocompletado con mini.completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "mini.completion") then
    -- Enlaza el protocolo nativo con el motor de "mini" para ventanas emergentes rápidas
    capabilities = require("mini.completion").update_capabilities(capabilities)
end

-- 3. Lista de servidores que tienes instalados en tu Arch Linux
-- Solo pon los nombres del ejecutable base de cada uno
local servers = {
    "lua-language-server",
    "pyright-langserver",
    "typescript-language-server",
    "vue-language-server"
}

-- 4. Bucle inteligente: Inicializa de golpe todos los servidores de la lista anterior
for _, server in ipairs(servers) do
    if vim.fn.executable(server) == 1 then
        -- Ajustes individuales especiales por lenguaje
        local config = {
            capabilities = capabilities,
            root_dir = vim.fs.root(0, { ".git", "init.lua", "package.json", "pyproject.toml" }),
        }

        -- Tratamiento específico para aislar las alertas globales en la API de Neovim (Lua)
        if server == "lua-language-server" then
            config.cmd = { "lua-language-server" }
            config.settings = {
                Lua = { diagnostics = { globals = { "vim" } } }
            }
        elseif server == "pyright-langserver" then
            config.cmd = { "pyright-langserver", "--stdio" }
        elseif server == "typescript-language-server" then
            config.cmd = { "typescript-language-server", "--stdio" }
        elseif server == "vue-languege-server" then
            config.cmd = { "vue-languege-server", "--stdio" }
            config.filetypes = { "vue" }  

        end

        -- Iniciar el servidor mediante la API nativa de Neovim
        vim.lsp.start(config)
    end
end

return lsp

