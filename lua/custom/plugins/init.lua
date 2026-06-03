-- 你可以在此目录下的此文件或其他文件中添加自己的插件！
--  我保证不会在这个目录中制造任何合并冲突 :)
--
-- 查看 kickstart.nvim 的 README 获取更多信息

-- 遍历插件目录中的所有 Lua 文件并加载它们
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end
