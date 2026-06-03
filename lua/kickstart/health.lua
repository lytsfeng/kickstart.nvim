--[[
--
-- 此文件不是你自己配置必需的，
-- 但可以帮助人们确定他们的系统是否正确设置。
--
--]]

local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim 版本过旧：'%s'。请升级到最新稳定版或 nightly 版", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.12') then
    vim.health.ok(string.format("Neovim 版本为：'%s'", verstr))
  else
    vim.health.error(string.format("Neovim 版本过旧：'%s'。请升级到最新稳定版或 nightly 版", verstr))
  end
end

local check_external_reqs = function()
  -- 基本工具：`git`、`make`、`unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("找到可执行文件：'%s'", exe))
    else
      vim.health.warn(string.format("未找到可执行文件：'%s'", exe))
    end
  end

  return true
end

return {
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[注意：在 `:checkhealth` 中，并非所有警告都是"必须修复"的

  只修复你打算使用的插件和语言的警告。
    Mason 会对未安装的语言给出警告。
    你不需要安装它们，除非你想使用这些语言！]]

    local uv = vim.uv or vim.loop
    vim.health.info('系统信息：' .. vim.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
