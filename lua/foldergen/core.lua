---@diagnostic disable: undefined-global

local M = {}

local function is_file(name)
  return name:match("^.+%..+$") ~= nil
end

local function clean_line(line)
  line = line:gsub("[│├└─]", "")
  line = line:gsub("^%s+", ""):gsub("%s+$", "")
  line = line:gsub("%s*#.*", "")
  return line
end

local function count_indent(line)
  local clean = line:gsub("[│├└─]", "")
  local _, count = clean:find("^%s*")
  return count or 0
end

local function is_tree_style(lines)
  for _, line in ipairs(lines) do
    if line:find("[│├└─]") or line:match("%S+%.%S+") then
      return true
    end
  end
  return false
end

function M.generate_from_text()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  if #lines == 0 then
    print("Buffer is empty! Please paste your tree structure first.")
    return
  end

  if not is_tree_style(lines) then
    print("No tree-style structure detected. Generation skipped.")
    return
  end

  local cwd = vim.fn.getcwd()
  local stack = { { path = cwd, depth = -1 } }
  local error_occurred = false

  for _, line in ipairs(lines) do
    local clean = clean_line(line)
    if clean ~= "" then
      local depth = count_indent(line)

      while stack[#stack].depth >= depth do
        table.remove(stack)
      end

      local parent_path = stack[#stack].path
      local path = parent_path .. "/" .. clean

      local success = pcall(function()
        if is_file(path) then
          vim.fn.writefile({}, path)
        else
          vim.fn.mkdir(path, "p")
          table.insert(stack, { path = path, depth = depth })
        end
      end)

      if not success then
        error_occurred = true
      end
    end
  end

  if error_occurred then
    print("Could not generate folder structure completely.")
  else
    print("Folder structure generated successfully!")
  end
end

return M
