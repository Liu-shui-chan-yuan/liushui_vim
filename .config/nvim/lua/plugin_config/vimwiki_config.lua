vim.g.vimwiki_list = {
  {
    path_html = "/mnt/e/vimwiki/programming/html",
    path = "/mnt/e/vimwiki/programming",
    syntax = "markdown",
    ext = ".md",
    custom_wiki2html = "~/.vim/autoload/wiki2html.sh",
  },
  {
    path_html = "/mnt/e/vimwiki/blog/html",
    path = "/mnt/e/vimwiki/blog",
    syntax = "markdown",
    ext = ".md",
    custom_wiki2html = "~/.vim/autoload/wiki2html.sh",
  },
}

vim.g.vimwiki_key_mappings = {
  all_maps = 1,
  global = 1,
  headers = 1,
  text_objs = 1,
  table_format = 1,
  table_mappings = 1,
  lists = 1,
  lists_return = 0,
  links = 1,
  html = 0,
  mouse = 0,
}

vim.g.vimwiki_global_ext = 1

vim.g.vimwiki_table_reduce_last_col = 1

vim.api.nvim_set_var('vimwiki_ext2syntax', {})

vim.g.vimwiki_ext2syntax = vim.empty_dict()

vim.g.vimwiki_conceallevel = 0
