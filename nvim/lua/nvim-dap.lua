local M = {}

local python_configuration = [[
{
    "configurations": [{
        "name": "Python: Launch",
        "type": "python",
        "request": "launch",
        "python": "%s",
        "stopOnEntry": false,
        "debugOptions": [],
        "program": "${file}",
        "args": []
    }]
}
]]

--- Generate debug profile. Currently for Python only
function M.generate_debug_profile()
    -- Get current file type
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")

    if ft == "python" then
        -- Get Python path

        local lines = {}
        local config_file = os.getenv("PWD") .. "/.vscode/launch.json"
        local f = io.open(config_file, 'r')

        vim.api.nvim_exec("Bdelete hidden", true)

        -- Generate debug profile in a new window
        vim.api.nvim_exec("vsp", true)
        local win = vim.api.nvim_get_current_win()
        local bufNew = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(bufNew, config_file)
        vim.api.nvim_win_set_buf(win, bufNew)
        vim.api.nvim_exec("set syntax=json", true)

        if f ~= nil then
            f:close()
            for lin in io.lines(config_file) do
                lines[#lines + 1] = lin
            end
        else
            local python3 = vim.fn.exepath "python"
            local debugProfile = string.format(python_configuration, python3)

            for s in debugProfile:gmatch "[^\r\n]+" do
                table.insert(lines, s)
            end
        end
        vim.api.nvim_buf_set_lines(bufNew, 0, -1, false, lines)
        vim.api.nvim_command('w!')
    end
end

return M
