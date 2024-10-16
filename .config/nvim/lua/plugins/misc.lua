return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically


  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'norcalli/nvim-colorizer.lua', lazy=false },
}
