_GlobalCallbacks = _GlobalCallbacks or {}

_G.globals = { _store = _GlobalCallbacks }

vim.g.ale_python_pylint_executable = 'flake8'
vim.g.ale_python_pyling_use_global = 1
vim.g.ale_virtualenv_dir_names = {'env', 'venv'}

vim.g.ale_fixers = {
    python = {'yapf'},
    cpp = {'clang-format'}
}

function globals._create(f)
    table.insert(globals._store, f)
    return #globals._store
end

function globals._execute(id, args)
    globals._store[id](args)
end
