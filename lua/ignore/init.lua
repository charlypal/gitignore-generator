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

function M.update_gitignore(arg)
    -- Open the .gitignore file for writing
    local gitignore = io.open('.gitignore', 'w')

    -- Iterate over the IGNORE_C table
    for _, line in ipairs(IGNORE_C) do
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
