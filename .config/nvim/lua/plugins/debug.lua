-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
-- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'theHamsta/nvim-dap-virtual-text',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio',
    'anuvyklack/hydra.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require("nvim-dap-virtual-text").setup()

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'cpptools',
      },
    }
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/rrentea/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }
    dap.adapters.python = {
      type = 'executable';
      command = "/home/rrentea/.pyenv/shims/python3",
      args = { '-m', 'debugpy.adapter' };
    }
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        -- pythonPath = function()
        --   return '/usr/bin/python'
        -- end;
      },
    }
    dap.configurations.cpp = {
      {
        name = "Ecnet tester",
        type = "cppdbg",
        request = "launch",
        program = "/work/bd/git/ecnet-tester/bin/linux-debug64/ecnet_tester",
        args = function()
          local args_string = vim.fn.input("Tester arguments: ")
          return vim.split(args_string, " ")
        end,
        -- environment = {
        --   {name = "BDNC_PATH", value = "/work/bd/ghostr/components/bdnc/latest/linux-release64/libbdnc.so"},
        --   {name = "HAUT_CVD_PATH", value = "/work/bd/git/ecnet_haut_sigs/bin/haut.cvd"},
        --   {name = "SID_DATA_PATH", value = "/work/bd/git/ecnet/bin/sid.data"},
        --   {name = "PORTALIB_PATH", value = "/work/bd/git/portalib/bin/linux-debug64/portalib.so"},
        --   {name = "ECNET_PATH", value = "/work/bd/git/ecnet/bin/linux-debug64/libEcNet.so"},
        -- },
        cwd = '/work/bd/git/ecnet-tester/bin/linux-debug64/',
        stopAtEntry = false,
      },
      -- {
      --   name = "Run aad_iot_test",
      --   type = "cppdbg",
      --   request = "launch",
      --   program = "/work/bd/ghostr/components/guster/latest/linux-64-release/guster",
      --   args = {
      --     "-C", "var_path=/work/bd/ghostr/var/dbg_var/",
      --     "-c", "/work/bd/ghostr/components/guster/config/linux/guster.yaml",
      --     "-C", "ecnet_path=/work/bd/git/ecnet/bin/linux-debug64",
      --     "-C", "craw_path=/work/bd/ghostr/components/craw/latest/linux-release64",
      --     "-C", "sav_path=/work/bd/ghostr/components/sav/latest/packages/linux_amd64/debug/DEVELOPMENT_NO_EMALWARE",
      --     "-C", "bdnc_path=/work/bd/ghostr/components/bdnc/latest/linux-release64/",
      --     "--file", "/work/bd/core_test/remote/infected/AAD/aad_iot_test.pcap"
      --   },
      --   cwd = '${workspaceFolder}',
      --   stopAtEntry = false,
      -- },
      {
        name = "Run aad_iot_test",
        type = "cppdbg",
        request = "attach",
        program = "/work/bd/ghostr/components/guster/latest/linux-64-release/guster",
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
      },
    }

    local run_command_if_active = function(command, fallback_key)
      if require('dap').session() == nil then
        local key = vim.api.nvim_replace_termcodes(fallback_key, true, false, true)
        vim.api.nvim_feedkeys(key, 'n', false)
      else
        command()
      end
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dc', function() dap.continue() end, {desc = "Debug Continue"})
    vim.keymap.set('n', '<leader>dC', function() dap.run_to_cursor() end, {desc = "Debug run to Cursor"})
    vim.keymap.set('n', 'J', function () run_command_if_active(dap.step_over, 'J') end, {desc = "Debug step over"})
    vim.keymap.set('n', 'L', function () run_command_if_active(dap.step_into, 'K') end, {desc = "Debug step into"})
    vim.keymap.set('n', 'H', function () run_command_if_active(dap.step_out, 'H') end, {desc = "Debug step oup"})
    vim.keymap.set('n', '<leader>dh', function() dap.toggle_breakpoint() end, {desc = "Debug toggle breakpoint"})
    vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint() end, {desc = "Debug set breakpoint"})
    vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, {desc = "Debug open Repl"})
    vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, {desc = "Debug run Last"})
    vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, {desc = "DapUI Toggle"})
    vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, {desc = "Debug Terminate"})
    -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    --   require('dapui').eval(nil, { enter = true })
    -- end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
