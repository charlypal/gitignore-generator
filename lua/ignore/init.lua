local dkjson = require 'dkjson'

local M = {}

function M.update_gitignore(arg)
    -- Read the template.json file
    local file = io.open('lua/ignore/template.json', 'r')
    local content = file:read('*all')
    file:close()

    -- Parse the JSON content into a Lua table
    local data = dkjson.decode(content)

    -- Open the .gitignore file for writing
    local gitignore = io.open('.gitignore', 'w')

    -- Iterate over the IGNORE_C table
    for _, line in ipairs(data.IGNORE_C) do
        -- Replace the %s placeholder
        if line == '%s' then
            -- Replace with the provided argument or "a.out" if no argument is provided
            line = arg or 'a.out'
        end

        -- Write the line to the .gitignore file
        gitignore:write(line .. '\n')
    end

    gitignore:close()
end

return M