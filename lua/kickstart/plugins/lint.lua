-- 代码检查

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'
lint.linters_by_ft = {
  python = { 'ruff' },             -- Python 快速检查（需安装 ruff）
  javascript = { 'eslint_d' },     -- JS 检查（需安装 eslint_d）
  typescript = { 'eslint_d' },     -- TS 检查
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  markdown = { 'markdownlint' }, -- 确保通过 mason / npm 安装了 `markdownlint`
}

-- 要允许其他插件向 require('lint').linters_by_ft 添加检查器，
-- 可以像这样设置 linters_by_ft：
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- 但请注意，这会启用一组默认的检查器，
-- 如果这些工具不可用，会导致错误：
-- {
--   clojure = { "clj-kondo" },
--   dockerfile = { "hadolint" },
--   inko = { "inko" },
--   janet = { "janet" },
--   json = { "jsonlint" },
--   markdown = { "vale" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- 你可以通过将文件类型设为 nil 来禁用默认检查器：
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil

-- 创建自动命令，在指定事件上执行实际的代码检查。
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- 只在可以修改的缓冲区中运行检查器，以避免
    -- 多余的噪音，特别是在使用 Markdown 描述悬停符号的
    -- 方便的 LSP 弹出窗口中。
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
