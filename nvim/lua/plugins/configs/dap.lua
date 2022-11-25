local ok1, dap = pcall(require, 'dap')
local ok2, dapui = pcall(require, 'dapui')

if not ok1 or not ok2 then
    return
end

dap.adapters.python = {
    type = 'executable';
    command = 'python';
    args = { '-m', 'debugpy.adapter' };
}
dap.adapters.cpp = {
  type = 'server',
  port = "13000",
  host = "127.0.0.1",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/rrentea/bin/extension/adapter/codelldb',
    args = {"--port", "13000"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

-- dap.adapters.cppdbg = {
--   id = 'cppdbg',
--   type = 'executable',
--   command = '/home/rrentea/bin/extension/debugAdapters/bin/OpenDebugAD7',
--   -- command = 'gdb',
--   options = {
--     detached = false
--   }
-- }

-- vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
-- vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

require("nvim-dap-virtual-text").setup {
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = 80 -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open(nil)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close(nil)
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close(nil)
end
