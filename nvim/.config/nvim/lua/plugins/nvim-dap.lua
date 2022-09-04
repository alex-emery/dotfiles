local dap = require "dap"

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', opts)

-- telescope-dap
vim.api.nvim_set_keymap('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
