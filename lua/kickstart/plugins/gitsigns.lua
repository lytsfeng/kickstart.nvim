-- 在侧边栏添加 git 相关标志，以及管理更改的工具
-- 注意：gitsigns 已经包含在 init.lua 中，但只有基本
-- 配置。这个文件还会添加推荐的按键映射。

vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- 导航
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = '跳到下一个 git [变]更' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = '跳到上一个 git [变]更' })

    -- 操作
    -- 可视模式
    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [暂]存块' })
    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [重]置块' })
    -- 普通模式
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [暂]存块' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [重]置块' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git 暂存[缓]冲区' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [重]置缓冲区' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [预]览块' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git 内联预览块' })
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [责]任行' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [对]比索引' })
    map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [对]比上次提交' })
    map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git 块[快]速修复列表（仓库中所有文件）' })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git 块[快]速修复列表（此文件中所有更改）' })
    -- 切换
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[切]换 git 显示[责]任行' })
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[切]换 git 行内[词]差异' })

    -- 文本对象
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end,
}
