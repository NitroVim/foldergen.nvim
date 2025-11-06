local M = {}

local function is_file(name)
    return name:match("^.+%..+$") ~= nil
end

local function indent_level(line)
    local _, count = line:find("^%s*")
    return count or 0
end

function M.generate_from_text()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cwd = vim.fn.getcwd()

    local stack = {cwd}
    local prev_indent = 0

    for _, line in ipairs(lines) do
        local clean = line:gsub("[│├└─]", ""):gsub("^%s+", "")
        clean = clean:gsub("%s*#.*", "")
        if clean ~= "" then
            local indent = indent_level(line)
            if indent > prev_indent then
                table.insert(stack, stack[#stack])
            elseif indent < prev_indent then
                local diff = (prev_indent - indent) // 2
                for i = 1, diff do
                    table.remove(stack)
                end
            end
            prev_indent = indent

            local path = stack[#stack] .. "/" .. clean

            if is_file(path) then
                vim.fn.writefile({}, path)
            else
                vim.fn.mkdir(path, "p")
                stack[#stack] = path
            end
        end
    end

    print("Folder structure generated successfully!")
end

return M
