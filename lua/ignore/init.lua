-- Import LunarVim APIs
local lv = require("lv-utils")
local fs = require("lv-fs")

local function load_ignore_c_from_json(filename)
    -- Load JSON content using LunarVim's file reading API
    local json_content = fs.read_file(filename)
    if not json_content then
        print("Error: Unable to open JSON file")
        return {}
    end

    -- Decode JSON content
    local data = lv.json_decode(json_content)
    if not data or not data.IGNORE_C then
        print("Error: Invalid JSON format or missing data")
        return {}
    end

    return data.IGNORE_C
end

local IGNORE_C = load_ignore_c_from_json(lv.path.join(lv.cwd, "lua", "ignore", "./lua/ignore/template.json"))

local function write_to_gitignore(content, binary_name)
    local file_path = ".gitignore"
    
    -- Write to .gitignore using LunarVim's file writing API
    local success, err = fs.write_to_file(file_path, table.concat(content, "\n"))
    if not success then
        print("Error writing to .gitignore: " .. err)
        return
    end

    print(".gitignore file created successfully.")
end

-- Extract binary name from arguments (if provided)
local binary_name = lv.cli_args[1] or "a.out"
write_to_gitignore(IGNORE_C, binary_name)

-- Expose functions for use in LunarVim configuration
return {
    load_ignore_c_from_json = load_ignore_c_from_json,
    write_to_gitignore = write_to_gitignore
}
