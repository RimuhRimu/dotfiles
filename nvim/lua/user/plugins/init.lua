return {
  { "folke/tokyonight.nvim" },
  {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZFocus",
      "TZAtaraxis",
      "TZMinimalist",
    },
    setup = function()
      require("user.plugins.true-zen").setup()
    end
  },
  {
    "easymotion/vim-easymotion"
  },
  {
    "mg979/vim-visual-multi"
  },
  {
    "t9md/vim-choosewin"
  },
  {
    "crispgm/nvim-go"
  },
  {
  'heavenshell/vim-jsdoc',
    run = 'make install'
  },
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    setup = require("user.plugins.todo-comments").setup()
  },
  {
    "mattn/emmet-vim"
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    requires = 'tpope/vim-rhubarb'
  },
  {
    "dbeniamine/cheat.sh-vim"
  },
}
