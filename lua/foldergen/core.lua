local M = {}

function M.generate_from_text()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cwd = vim.fn.getcwd()

  for _, line in ipairs(lines) do
    local clean = line:gsub("[│├└─]", ""):gsub("^%s+", "")
    if clean ~= "" then
      local path = cwd .. "/" .. clean
      if path:match("%.%w+$") then
        vim.fn.writefile({}, path)
      else
        vim.fn.mkdir(path, "p")
      end
    end
  end

  print("✅ Folder structure generated successfully!")
end

return M
