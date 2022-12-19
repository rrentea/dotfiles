local ok, ale = pcall(require, 'ale')

if not ok then
    return
end

vim.g.ale_python_pylint_executable = 'flake8'
vim.g.ale_python_pyling_use_global = 1
vim.g.ale_virtualenv_dir_names = {'env', 'venv'}

vim.g.ale_fixers = {
    python = {'yapf'},
    cpp = {'clang-format'}
}

ale.setup()
