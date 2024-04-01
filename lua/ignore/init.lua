local M = {}
local cjson = require("cjson")

local function load_ignore_c_from_json(filename)
    local file, err = io.open(filename, "r")
    if not file then
        print("Error: Unable to open JSON file '" .. filename .. "': " .. err)
        return {}
    end

    local json_content = file:read("*all")
    file:close()

    local data = cjson.decode(json_content)
    if not data or not data.IGNORE_C then
        print("Error: Invalid JSON format or missing data in file '" .. filename .. "'")
        return {}
    end

    return data.IGNORE_C
end

local function write_to_gitignore(content, binary_name)
    local file_path = ".gitignore"
    local file, err = io.open(file_path, "w")

    if not file then
        print("Error: Unable to create .gitignore file: " .. err)
        return
    end

    for _, line in ipairs(content) do
        -- Replace %s with binary_name
        line = line:gsub("%%s", binary_name)
        file:write(line .. "\n")
    end

    file:close()
    print(".gitignore file created successfully.")
end

function M.generate_gitignore(binary_name, json_path)
    binary_name = binary_name:gsub("'", "") -- Remove single quotes
    local IGNORE_C = load_ignore_c_from_json(json_path)
    write_to_gitignore(IGNORE_C, binary_name)
end

return M
