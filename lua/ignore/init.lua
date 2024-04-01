local M = {}

local IGNORE_C =
{
    "# Authored by @charlypal",
    "# Object File",
    "*.o",
    "*.ko",
    "*.obj",
    "*.elf",
    "",
    "# Libraries",
    "*.lib",
    "*.a",
    "*.la",
    "*.lo",
    "",
    "# Executable",
    "*.exe",
    "*.out",
    "*.app",
    "*.hex",
    "*.sh",
    "",
    "# Debug output",
    "vgcore.*",
    "gmon.out",
    "*.gcda",
    "*.gcno",
    "perf.data",
    "strace.out",
    "*.dot",
    "",
    "# Subject File",
    "*.pdf",
    "",
    "# EPITECH Coding Style",
    "coding-style-reports.log",
    "",
    "# Binary File",
    "%s"
}

function M.update_gitignore()
    -- Ask for the programming language
    io.write("Enter the programming language: ")
    local language = io.read()

    -- If the language is 'C', write the IGNORE_C content to the .gitignore file
    if language and language:lower() == 'c' then
        -- Open the .gitignore file for writing
        local gitignore = io.open('.gitignore', 'w')

        -- Iterate over the IGNORE_C table
        for _, line in ipairs(IGNORE_C) do
            -- Replace the %s placeholder
            if line == '%s' then
                -- Replace with "a.out"
                line = 'a.out'
            end

            -- Write the line to the .gitignore file
            gitignore:write(line .. '\n')
        end

        gitignore:close()
    else
        -- If the language is not 'C', just create an empty .gitignore file
        local gitignore = io.open('.gitignore', 'w')
        gitignore:close()
    end
end

return M
