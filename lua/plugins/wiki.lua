return {
  {
    "vimwiki/vimwiki",
    cmd = "VimwikiIndex",
  },
  {
    "KabbAmine/zeavim.vim",
    event = "BufReadPost",
    keys = {
      { "<leader>z", "<cmd>Zeavim<cr>", desc = "Open zeavim for current word" },
      { "<leader>z", ":ZeavimV<cr>", mode = "v", desc = "Open zeavim for current selection" },
      { "<leader><leader>z", "<cmd>ZVKeyDocset<cr>", desc = "Open zeavim with manual doc set" },
    },
  },
}
