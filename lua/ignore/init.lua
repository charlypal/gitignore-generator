local M = {}

local IGNORE_C = {
    "# Authored by @charlypal",
    "# Object File",
    "*.o",
    "*.ko",
    "*.obj",
    "*.elf",
    "",
    "# Librairies",
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


local function customize_ignore_c(binary_name)
    local customized_ignore_c = {}
    for _, line in ipairs(IGNORE_C) do
        if type(line) == "string" then
            customized_ignore_c[#customized_ignore_c + 1] = line:gsub("%%s", binary_name)
        else
            print("Error: line is not a string")
        end
    end
    return customized_ignore_c
end

local function generate_gitignore_c(binary_name)
    local customized_ignore_c = customize_ignore_c(binary_name)

    local file_path = ".gitignore"
    local file, err = io.open(file_path, "w")

    if not file then
        print("Error opening file: " .. err)
        return
    end

    for _, line in ipairs(customized_ignore_c) do
        file:write(line .. "\n")
    end

    file:close()
    print(".gitignore for C project generated successfully.")
end

function M.main(binary_name)
    binary_name = binary_name:gsub("'", "")
    generate_gitignore_c(binary_name)
end

return M
