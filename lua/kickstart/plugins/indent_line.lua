-- 即使在空白行也添加缩进指南

-- 启用 `lukas-reineke/indent-blankline.nvim`
-- 参见 `:help ibl`
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}
