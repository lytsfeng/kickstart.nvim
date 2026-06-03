--[[

=====================================================================
==================== 继续前请先阅读本文 ====================
=====================================================================
========                                 .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

什么是 Kickstart？

  Kickstart.nvim **不是**一个发行版。

  Kickstart.nvim 是你个人配置的起点。
    目标是让你能从上到下阅读每一行代码，理解
    你的配置在做什么，并根据需要修改它。

    完成之后，你就可以开始探索、配置和调整，
    让 Neovim 成为你自己的编辑器！这可能意味着暂时保持 Kickstart 原样，
    或者立即将其拆分为模块化组件。由你决定！

    如果你对 Lua 一无所知，我建议花些时间阅读
    一份教程。一个只需 10-15 分钟的示例：
      - https://learnxinyminutes.com/docs/lua/

    对 Lua 有了基本了解后，可以使用 `:help lua-guide` 作为
    了解 Neovim 如何集成 Lua 的参考。
    - :help lua-guide
    - （或 HTML 版本）：https://neovim.io/doc/user/lua-guide.html

Kickstart 指南：

  TODO：你应该做的第一件事是在 Neovim 中运行命令 `:Tutor`。

    如果你不知道这意味着什么，请按以下步骤操作：
      - 按 <escape 键>
      - 输入 :
      - 输入 Tutor
      - 按 <enter 键>

    （如果你已经了解 Neovim 基础，可以跳过此步。）

  完成之后，你可以继续学习**并阅读** kickstart init.lua 的其余部分。

  接下来，运行并阅读 `:help`。
    这将打开一个帮助窗口，包含一些基本信息，
    关于如何阅读、导航和搜索内置帮助文档。

    当你遇到困难或对某些东西感到困惑时，这应该是你首先查阅的地方。
    这是我最喜欢的 Neovim 功能之一。

    **最重要的是**，我们提供了一个按键映射 "<space>sh" 来[搜]索帮[助]文档，
    当你不确定要找什么时非常有用。

  我在 init.lua 中留下了几个 `:help X` 注释
    这些是关于在哪里找到相关设置、插件或
    Kickstart 中使用的 Neovim 功能的提示。

   注意：请寻找像这样的注释行

    遍布整个文件。这些是为你——读者——准备的，帮助你理解正在发生的事情。
    一旦你掌握了要领，可以随意删除它们，但它们应该在
    你首次接触 Neovim 配置中的各种结构时起到指导作用。

如果在安装 kickstart 时遇到任何错误，请运行 `:checkhealth` 获取更多信息。

希望你享受 Neovim 之旅，
- TJ

附：完成后你也可以删除这段内容。现在这是你的配置了！:)
--]]

-- ============================================================
-- 第 1 节：基础
-- 核心 Neovim 设置、leader 键、选项、基本按键映射、基本自动命令
-- ============================================================
do
  -- 通过缓存编译的 Lua 模块加速启动
  vim.loader.enable()

  -- 设置 <空格> 为 leader 键
  -- 参见 `:help mapleader`
  --  注意：必须在加载插件之前设置（否则会使用错误的 leader 键）
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- 如果安装了 Nerd Font 并在终端中选中，设为 true
  vim.g.have_nerd_font = false

  -- [[ 设置选项 ]]
  --  参见 `:help vim.o`
  -- 注意：你可以随意更改这些选项！
  --  更多选项，请查看 `:help option-list`

  -- 默认显示行号
  vim.o.number = true
  -- 你也可以添加相对行号，有助于跳转。
  --  自己试试看喜不喜欢！
  -- vim.o.relativenumber = true

  -- 启用鼠标模式，例如在调整分割窗口大小时有用！
  vim.o.mouse = 'a'

  -- 不显示模式，因为状态栏已经显示了
  vim.o.showmode = false

  -- 同步操作系统和 Neovim 的剪贴板。
  --  安排在 `UiEnter` 之后设置，因为它会增加启动时间。
  --  如果希望操作系统剪贴板保持独立，请移除此选项。
  --  参见 `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- 启用断行缩进
  vim.o.breakindent = true

  -- 即使关闭并重新打开文件，也保留撤销/重做更改
  vim.o.undofile = true

  -- 不区分大小写搜索，除非包含 \C 或搜索词中有大写字母
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- 默认显示符号列
  vim.o.signcolumn = 'yes'

  -- 减少更新时间
  vim.o.updatetime = 250

  -- 减少按键序列等待时间
  vim.o.timeoutlen = 300

  -- 配置新分割窗口的打开方式
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- 设置 neovim 如何显示编辑器中的某些空白字符。
  --  参见 `:help 'list'`
  --  和 `:help 'listchars'`
  --
  --  注意 listchars 是使用 `vim.opt` 而不是 `vim.o` 设置的。
  --  它与 `vim.o` 非常相似，但提供了更方便的表格交互接口。
  --   参见 `:help lua-options`
  --   和 `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- 实时预览替换结果！
  vim.o.inccommand = 'split'

  -- 显示光标所在行
  vim.o.cursorline = true

  -- 光标上下方保留的最少屏幕行数。
  vim.o.scrolloff = 10

  -- 如果执行的操作会因缓冲区有未保存的更改而失败（如 `:q`），
  -- 则弹出对话框询问是否要保存当前文件
  -- 参见 `:help 'confirm'`
  vim.o.confirm = true

  -- [[ 基本按键映射 ]]
  --  参见 `:help vim.keymap.set()`

  -- 在普通模式下按 <Esc> 清除搜索高亮
  --  参见 `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- 诊断配置和按键映射
  --  参见 `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- 可以按喜好切换这些选项
    virtual_text = true, -- 文本显示在行尾
    virtual_lines = false, -- 文本显示在行下方，使用虚拟行

    -- 自动打开浮动窗口，方便使用 `[d` 和 `]d` 跳转时阅读错误
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '打开诊断[快]速修复列表' })

  -- 用一个更容易发现的快捷键退出内置终端的终端模式。
  -- 否则，通常需要按 <C-\><C-n>，没有一定经验的人猜不到。
  --
  -- 注意：这在所有终端模拟器/tmux 等中可能不起作用。
  -- 尝试自己的映射，或者直接使用 <C-\><C-n> 退出终端模式
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = '退出终端模式' })

  -- 提示：在普通模式下禁用方向键
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- 使分割窗口导航更便捷的按键绑定。
  --  使用 CTRL+<hjkl> 在窗口间切换
  --
  --  参见 `:help wincmd` 获取所有窗口命令列表
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = '将焦点移到左侧窗口' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = '将焦点移到右侧窗口' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = '将焦点移到下方窗口' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = '将焦点移到上方窗口' })

  -- 注意：某些终端有冲突的按键映射，或无法发送不同的键码
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ 基本自动命令 ]]
  --  参见 `:help lua-guide-autocommands`

  -- 复制文本时高亮
  --  在普通模式下用 `yap` 试试
  --  参见 `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = '复制文本时高亮',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- 第 2 节：插件管理器介绍
-- vim.pack 介绍、构建钩子
-- ============================================================
do
  -- [[ `vim.pack` 介绍 ]]
  -- `vim.pack` 是 Neovim 内置的插件管理器，
  --  提供用于安装和管理插件的 Lua 接口。
  --
  --  参见 `:help vim.pack`、`:help vim.pack-examples` 或
  --  vim.pack 和 mini.nvim 作者的博客文章：
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  检查插件状态和待处理更新，运行
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  更新插件，运行
  --    :lua vim.pack.update()
  --
  --
  --  在配置的其余部分中，将有示例展示如何使用 `vim.pack`
  --  安装和配置插件。
  --
  --  在本节中，我们设置了一些自动命令，在特定插件
  --  安装或更新后运行构建步骤。

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = '构建命令无输出。' end
      vim.notify(('%s 构建失败：\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- 此自动命令在插件安装或更新后运行，
  --  并在必要时执行该插件的适当构建命令。
  --
  -- 参见 `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---由于大多数插件托管在 GitHub 上，可以使用此辅助
---函数来减少后续部分的重复代码。
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- 第 3 节：UI / 核心用户体验插件
-- guess-indent、gitsigns、which-key、颜色主题、todo-comments、mini 模块
-- ============================================================
do
  -- [[ 安装和配置插件 ]]
  --
  -- 使用 `vim.pack.add` 并传入 git 地址即可安装插件。
  -- 这将下载插件的默认分支，通常是 `main` 或 `master`。
  -- 你也可以使用更高级的规范，后面会介绍。
  --
  -- 对大多数插件来说，仅安装还不够，还需要调用它们的 `.setup()` 来启动。
  --
  -- 例如，假设我们要安装 `guess-indent.nvim` —— 一个用于
  -- 自动检测和设置缩进的插件。
  --
  -- 首先从 https://github.com/NMAC427/guess-indent.nvim 安装它，
  -- 然后调用其 `setup()` 函数以默认设置启动。
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- 因为 Lua 是真正的编程语言，你还可以在安装中加入一些逻辑——
  -- 比如只有在满足条件时才安装插件。
  --
  -- 这里我们只在有 Nerd Font 时才安装 `nvim-web-devicons`（添加漂亮图标），
  -- 否则图标无法正确显示。
  if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

  -- 这是一个更高级的配置示例，向 `gitsigns.nvim` 传递选项。
  --
  -- 参见 `:help gitsigns` 了解每个配置键的作用。
  -- 在侧边栏添加 git 相关标志，以及管理更改的工具
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  -- 显示待定按键绑定的实用插件。
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- 按键按下到打开 which-key 的延迟（毫秒）
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- 记录现有的按键链
    spec = {
      { '<leader>s', group = '[搜]索', mode = { 'n', 'v' } },
      { '<leader>t', group = '[切]换' },
      { '<leader>h', group = 'Git [块]', mode = { 'n', 'v' } }, -- 首先启用 gitsigns 推荐的按键映射
      { 'gr', group = 'LSP 操作', mode = { 'n' } },
    },
  }

  -- [[ 颜色主题 ]]
  -- 你可以轻松更换为不同的颜色主题。
  -- 更改下面颜色主题插件的名称，然后
  -- 修改下面的命令以加载相应名称的颜色主题。
  --
  -- 如果想查看已安装的颜色主题，可以使用 `:Telescope colorscheme`。
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- 禁用注释中的斜体
    },
  }

  -- 在这里加载颜色主题。
  -- 与许多其他主题一样，这个主题有不同的风格，你可以加载
  -- 其他风格，如 'tokyonight-storm'、'tokyonight-moon' 或 'tokyonight-day'。
  vim.cmd.colorscheme 'tokyonight-night'

  -- 在注释中高亮 TODO、笔记等
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  各种小型独立插件/模块的集合
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- 更好的 Around/Inside 文本对象
  --
  -- 示例：
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- 注意：避免与 Neovim>=0.12 的内置增量选择映射冲突（参见 `:help treesitter-incremental-selection`）
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- 添加/删除/替换包围符号（括号、引号等）
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- 简单易用的状态栏。
  --  如果不喜欢，可以移除此设置调用，
  --  尝试其他状态栏插件
  local statusline = require 'mini.statusline'
  -- 如果有 Nerd Font，设置 `use_icons` 为 true
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- 你可以通过覆盖默认行为来配置状态栏中的各个部分。
  -- 例如，这里将光标位置部分设置为 行:列
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... 还有更多功能！
  --  查看：https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- 第 4 节：搜索与导航
-- Telescope 设置、按键映射、LSP 选择器映射
-- ============================================================
do
  -- [[ 模糊查找器（文件、LSP 等）]]
  --
  -- Telescope 是一个模糊查找器，可以模糊查找很多不同的东西！
  -- 它不仅仅是"文件查找器"，还可以搜索 Neovim、工作区、LSP 等许多方面！
  --
  -- 还有很多其他替代选择器（如 snacks.picker 或 fzf-lua），
  -- 所以可以自由尝试，看看你喜欢哪个！
  --
  -- 使用 Telescope 的最简单方式是从类似这样的命令开始：
  --  :Telescope help_tags
  --
  -- 运行此命令后，会打开一个窗口，你可以在其中
  -- 输入内容。你会看到 `help_tags` 选项列表和
  -- 相应的帮助预览。
  --
  -- 在 Telescope 中有两个重要的按键映射：
  --  - 插入模式：<c-/>
  --  - 普通模式：?
  --
  -- 这会在当前 Telescope 选择器中打开一个窗口，
  -- 显示所有按键映射。这对了解 Telescope 的功能
  -- 以及如何使用非常有用！

  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- 注意：可以一次安装多个插件
  vim.pack.add(telescope_plugins)

  -- 参见 `:help telescope` 和 `:help telescope.setup()`
  require('telescope').setup {
    -- 你可以在这里放置默认映射/更新等
    --  所有需要的信息都在 `:help telescope.setup()` 中
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- 如果已安装，启用 Telescope 扩展
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- 参见 `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[搜]索帮[助]' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[搜]索按键[映]射' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[搜]索[文]件' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[搜]索[选]择 Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[搜]索当前[词]' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[搜]索（[正]则）' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[搜]索[诊]断' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[搜]索[恢]复' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[搜]索最近文件（"."重复）' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[搜]索[命]令' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] 查找现有缓冲区' })

  -- 当 LSP 附加到缓冲区时，添加基于 Telescope 的 LSP 选择器。
  -- 如果以后切换选择器插件，就在这里更新这些映射。
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- 查找光标下单词的引用。
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '跳转到[引]用' })

      -- 跳转到光标下单词的实现。
      -- 当语言有声明类型但不提供实际实现时很有用。
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '跳转到[实]现' })

      -- 跳转到光标下单词的定义。
      -- 这是变量首次声明或函数定义的位置。
      -- 按 <C-t> 跳回。
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '跳转到[定]义' })

      -- 模糊查找当前文档中的所有符号。
      -- 符号包括变量、函数、类型等。
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = '打开文档符号' })

      -- 模糊查找当前工作区中的所有符号。
      -- 类似于文档符号，但搜索范围是整个项目。
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = '打开工作区符号' })

      -- 跳转到光标下单词的类型。
      -- 当你不确定变量类型，想查看其*类型*的定义，
      -- 而不是其*定义*位置时很有用。
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '跳转到[类]型定义' })
    end,
  })

  -- 搜索时覆盖默认行为和主题
  vim.keymap.set('n', '<leader>/', function()
    -- 可以向 Telescope 传递额外配置来更改主题、布局等。
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] 在当前缓冲区中模糊搜索' })

  -- 也可以传递额外的配置选项。
  --  参见 `:help telescope.builtin.live_grep()` 了解特定键的信息
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = '在打开的文件中搜索',
      }
    end,
    { desc = '在打开的文件中[搜]索[/]' }
  )

  -- 搜索 Neovim 配置文件的快捷方式
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[搜]索[N]eovim 文件' })
end

-- ============================================================
-- 第 5 节：LSP
-- LSP 按键映射、服务器配置、Mason 工具安装
-- ============================================================
do
  -- [[ LSP 配置 ]]
  -- 简要说明：**什么是 LSP？**
  --
  -- LSP 是一个你可能听过但不一定理解的缩写。
  --
  -- LSP 代表 Language Server Protocol（语言服务器协议）。
  -- 它是一种帮助编辑器和语言工具以标准化方式通信的协议。
  --
  -- 一般来说，有一个"服务器"，它是为理解特定语言而构建的工具
  -- （如 `gopls`、`lua_ls`、`rust_analyzer` 等）。这些语言服务器
  -- （有时称为 LSP 服务器）是独立的进程，
  -- 与某个"客户端"通信——在这里就是 Neovim！
  --
  -- LSP 为 Neovim 提供以下功能：
  --  - 转到定义
  --  - 查找引用
  --  - 自动补全
  --  - 符号搜索
  --  - 以及更多！
  --
  -- 因此，语言服务器是必须与 Neovim 分开安装的外部工具。
  -- 这就是 `mason` 及相关插件发挥作用的地方。
  --
  -- 如果你对 lsp 与 treesitter 的区别感到困惑，
  -- 可以查看编写优美的帮助文档 `:help lsp-vs-treesitter`

  -- LSP 的实用状态更新。
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  --  当 LSP 附加到特定缓冲区时，此函数会被执行。
  --   也就是说，每次打开与某 LSP 关联的新文件时
  --   （例如，打开 `main.rs` 与 `rust_analyzer` 关联），
  --   此函数将被执行以配置当前缓冲区
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- 注意：记住 Lua 是一种真正的编程语言，因此可以
      -- 定义小的辅助和工具函数来避免重复代码。
      --
      -- 在本例中，我们创建了一个函数，可以更轻松地
      -- 定义 LSP 相关的映射。它自动设置模式、缓冲区和描述。
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- 重命名光标下的变量。
      --  大多数语言服务器支持跨文件重命名等。
      map('grn', vim.lsp.buf.rename, '[重]命[名]')

      -- 执行代码操作，通常光标需要位于错误或 LSP 建议上才能激活。
      map('gra', vim.lsp.buf.code_action, '代码[操]作', { 'n', 'x' })

      -- 警告：这不是转到定义，而是转到声明。
      --  例如，在 C 中，这将带你到头文件。
      map('grD', vim.lsp.buf.declaration, '[转]到[声]明')

      -- 以下两个自动命令用于当光标在某处停留片刻时，
      -- 高亮光标下单词的引用。
      --   参见 `:help CursorHold` 了解何时执行
      --
      -- 移动光标时，高亮将被清除（第二个自动命令）。
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- 以下代码创建了一个按键映射，用于切换代码中的内联提示，
      -- 如果你使用的语言服务器支持此功能
      --
      -- 这可能不是你想要的，因为它们会占据你代码的部分位置
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '切换内联[提]示')
      end
    end,
  })

  -- 启用以下语言服务器
  --  你可以在此自由添加/删除任何想要的 LSP。它们会被自动安装。
  --  参见 `:help lsp-config` 了解键的作用和如何配置
  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    --
    -- 某些语言（如 typescript）有完整的语言插件，可能会很有用：
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- 但对大多数设置而言，LSP（`ts_ls`）就已经够用了
    -- ts_ls = {},

    stylua = {}, -- 用于格式化 Lua 代码

    -- 特殊的 Lua 配置，遵循 neovim 帮助文档的推荐
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- 禁用格式化（格式化由 stylua 完成）

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- 注意：这会慢很多，并且在处理你自己的配置时可能引起问题。
            --  参见 https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- 禁用格式化（格式化由 stylua 完成）
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- 自动将 LSP 和相关工具安装到 Neovim 的 stdpath
  require('mason').setup {}

  -- 确保上述服务器和工具已安装
  --
  -- 查看已安装工具的当前状态和/或手动安装
  -- 其他工具，可以运行
  --    :Mason
  --
  -- 在此菜单中按 `g?` 可以获取帮助。
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- 你可以在这里添加其他想让 Mason 安装的工具
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- 第 6 节：格式化
-- conform.nvim 设置和按键映射
-- ============================================================
do
  -- [[ 格式化 ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- 你可以在此指定保存时自动格式化的文件类型：
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- 如果下面配置了外部格式化工具则使用它，否则使用 LSP 格式化。设为 `false` 完全禁用 LSP 格式化。
    },
    -- 你也可以在此指定外部格式化工具。
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform 也可以按顺序运行多个格式化工具
      -- python = { "isort", "black" },
      --
      -- 使用 'stop_after_first' 运行列表中第一个可用的格式化工具
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[格]式化缓冲区' })
end

-- ============================================================
-- 第 7 节：自动补全与代码片段
-- blink.cmp 和 luasnip 设置
-- ============================================================
do
  -- [[ 代码片段引擎 ]]

  -- 注意：也可以使用 git tag 的版本范围来指定插件。
  --  参见 `:help vim.version.range()` 了解更多信息
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` 包含各种预制代码片段。
  --    查看 README 了解各语言/框架/插件的代码片段：
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ 自动补全引擎 ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default'（推荐）使用类似内置补全的映射
      --   <c-y> 接受（[y]es）补全。
      --    如果 LSP 支持，会自动导入。
      --    如果 LSP 发送了代码片段，会展开它。
      -- 'super-tab' 使用 Tab 接受
      -- 'enter' 使用回车接受
      -- 'none' 不使用映射
      --
      -- 要了解为什么推荐使用 'default' 预设，
      -- 你需要阅读 `:help ins-completion`
      --
      -- 真的，请认真阅读 `:help ins-completion`，它写得非常好！
      --
      -- 所有预设都包含以下映射：
      -- <tab>/<s-tab>: 移动到代码片段展开的右/左边
      -- <c-space>: 打开菜单或如果已打开则打开文档
      -- <c-n>/<c-p> 或 <up>/<down>: 选择上/下一个项目
      -- <c-e>: 隐藏菜单
      -- <c-k>: 切换签名帮助
      --
      -- 查看 `:help blink-cmp-config-keymap` 了解如何自定义按键映射
      preset = 'default',

      -- 更高级的 Luasnip 按键映射（如选择选择节点、展开）参见：
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono'（默认）用于 'Nerd Font Mono'，'normal' 用于 'Nerd Font'
      -- 调整间距确保图标对齐
      nerd_font_variant = 'mono',
    },

    completion = {
      -- 默认情况下，可以按 `<c-space>` 显示文档。
      -- 也可以设置 `auto_show = true` 在延迟后自动显示文档。
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp 包含一个可选的、推荐的 rust 模糊匹配器，
    -- 启用时会自动下载预构建的二进制文件。
    --
    -- 默认使用 Lua 实现，但你可以通过 `'prefer_rust_with_warning'`
    -- 启用 rust 实现。
    --
    -- 参见 `:help blink-cmp-config-fuzzy` 了解更多信息
    fuzzy = { implementation = 'lua' },

    -- 在输入函数参数时显示签名帮助窗口
    signature = { enabled = true },
  }
end

-- ============================================================
-- 第 8 节：TREESITTER
-- 解析器安装、语法高亮、折叠、缩进
-- ============================================================
do
  -- [[ 配置 Treesitter ]]
  --  用于代码的高亮、编辑和导航
  --
  --  参见 `:help nvim-treesitter-intro`

  -- 注意：也可以指定分支或特定的提交
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- 确保基本的解析器已安装
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- 检查解析器是否存在并加载
    if not vim.treesitter.language.add(language) then return end
    -- 启用语法高亮和其他 treesitter 功能
    vim.treesitter.start(buf, language)

    -- 启用基于 treesitter 的折叠
    -- 更多关于折叠的信息参见 `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- 检查 treesitter 缩进是否适用于此语言，如果是则启用
    -- 如果没有缩进查询，indentexpr 会回退到 vim 的内置方式
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- 启用基于 treesitter 的缩进
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- 如果解析器已安装，直接启用
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- 如果 `nvim-treesitter` 中有该解析器，自动安装并在安装完成后启用
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- 尝试启用 treesitter 功能，以防解析器存在但不在 `nvim-treesitter` 中
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- 第 9 节：可选示例 / 后续步骤
-- kickstart.plugins.* 示例
-- ============================================================
do
  -- 以下注释仅在你下载了 kickstart 仓库而非仅复制粘贴 init.lua 时有效。
  -- 如果你想要这些文件，它们在仓库中，你可以直接下载并放到正确位置。

  -- 注意：Neovim 之旅的下一步：为 Kickstart 添加/配置更多插件
  --
  --  以下是我已包含在 Kickstart 仓库中的一些示例插件。
  --  取消下面任意行的注释以启用它们（你需要重启 nvim）。
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'
  -- require 'kickstart.plugins.gitsigns' -- 添加 gitsigns 推荐的按键映射

  -- 注意：你可以从 `lua/custom/plugins/*.lua` 添加自己的插件配置等
  --
  --  取消下面行的注释，然后将你的插件添加到 `lua/custom/plugins/*.lua` 即可。
  -- require 'custom.plugins'
end

-- 下面这一行叫做 `modeline`。参见 `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
