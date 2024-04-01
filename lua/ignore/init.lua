local json = require("dkjson")

local function load_ignore_c_from_json(filename)
    local file, err = io.open(filename, "r")
    if not file then
        print("Error: Unable to open JSON file - " .. err)
        return {}
    end

    local json_content = file:read("*all")
    file:close()

    local data = json.decode(json_content)
    if not data or not data.IGNORE_C then
        print("Error: Invalid JSON format or missing data")
        return {}
    end

    return data.IGNORE_C
end

local IGNORE_C = load_ignore_c_from_json("./lua/ignore/template.json")

local function write_to_gitignore(content, binary_name)
    local file_path = ".gitignore"
    local file, err = io.open(file_path, "w")

    if not file then
        print("Error opening file: " .. err)
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

function Main(binary_name)
    binary_name = binary_name:gsub("'", "")
    write_to_gitignore(IGNORE_C, binary_name)
end
