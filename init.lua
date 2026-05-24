-- Habilita la interfaz core moderna de Neovim 0.12
require("vim._core.ui2").enable({})

-- Carga tus opciones, comandos y paquetes individuales
require("keymaps")
require("options")
require("pack")
require("commands")
require("treesitter")
require("lsp")

