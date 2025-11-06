local folder_gen = require("folder_gen.core")

vim.api.nvim_create_user_command("FolderGen", function()
  folder_gen.generate_from_text()
end, {})
