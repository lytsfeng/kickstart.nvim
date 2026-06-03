# kickstart.nvim

## 介绍

Neovim 的起始配置，特点是：

* 精简
* 单文件
* 完整注释

**不是** Neovim 发行版，而是你个人配置的起点。

## 安装

### 安装 Neovim

Kickstart.nvim 仅支持最新的
['stable'](https://github.com/neovim/neovim/releases/tag/stable) 和
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) 版本。
如果遇到问题，请确保你至少安装了最新的稳定版本。
推荐通过[包管理器](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)安装 neovim。
运行 `nvim --version` 检查版本，确保不低于最新的
['stable'](https://github.com/neovim/neovim/releases/tag/stable) 版本。
如果安装方式只提供旧版本，请查看下面的[替代安装方法](#替代-neovim-安装方法)。

### 安装外部依赖

外部依赖：
- 基础工具：`git`、`make`、`unzip`、C 编译器（`gcc`）
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)、
  [fd-find](https://github.com/sharkdp/fd#installation)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
- 剪贴板工具（xclip/xsel/win32yank 等，取决于平台）
- [Nerd Font](https://www.nerdfonts.com/)（可选）：提供各种图标
  - 如果已安装，在 `init.lua` 中将 `vim.g.have_nerd_font` 设为 true
- Emoji 字体（仅 Ubuntu，且需要 emoji 时）：`sudo apt install fonts-noto-color-emoji`
- 语言设置：
  - 如果要写 TypeScript，需要 `npm`
  - 如果要写 Go，需要 `go`
  - 其他语言类推

> [!NOTE]
> 有关 Windows 和 Linux 的特定说明及快速安装脚本，请参见[安装方案](#安装方案)

### 安装 Kickstart

> [!NOTE]
> [备份](#常见问题)你之前的配置（如果有的话）

Neovim 配置文件的路径，取决于你的操作系统：

| 系统 | 路径 |
| :- | :--- |
| Linux、macOS | `$XDG_CONFIG_HOME/nvim`、`~/.config/nvim` |
| Windows (cmd) | `%localappdata%\nvim\` |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\` |

#### 推荐步骤

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) 本仓库，
以便你拥有自己的副本进行修改，然后根据你的系统用以下命令之一克隆到本地。

> [!NOTE]
> 你 fork 的 URL 格式如下：
> `https://github.com/<你的_github_用户名>/kickstart.nvim.git`

你可能还想从 fork 的 `.gitignore` 中移除 `nvim-pack-lock.json` 文件 —
kickstart 仓库中忽略它是为了便于维护，但推荐在版本控制中跟踪它（参见 `:help vim.pack-lockfile`）。

#### 克隆 kickstart.nvim

> [!NOTE]
> 如果按上述推荐步骤操作（即 fork 仓库），请将下面命令中的 `nvim-lua` 替换为 `<你的_github_用户名>`

<details><summary>Linux 和 Mac</summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Windows</summary>

如果使用 `cmd.exe`：

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

如果使用 `powershell.exe`：

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### 安装后

启动 Neovim：

```sh
nvim
```

就这样！`vim.pack` 会从你的配置中安装所有插件。使用
`:lua vim.pack.update(nil, { offline = true })` 检查插件状态，
使用 `:lua vim.pack.update()` 获取更新（`:write` 应用更新，`:quit` 取消更新）。

#### 阅读友好文档

阅读配置文件夹中的 `init.lua` 文件，了解更多关于扩展和探索 Neovim 的信息。
其中还包含常用插件的添加示例。

> [!NOTE]
> 关于特定插件的更多信息，请查看其仓库的文档。

### 入门指南

[开始使用 Neovim 的唯一必备视频](https://youtu.be/m8C0Cq9Uv9o)

### 常见问题

* 如果我已经有现有的 Neovim 配置该怎么办？
  * 你应该备份并删除所有相关文件。
  * 这包括现有的 init.lua 和 `~/.local` 中的 Neovim 文件，可以用 `rm -rf ~/.local/share/nvim/` 删除。
* 我能否保留现有配置与 kickstart 共存？
  * 可以！你可以使用 [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME` 来维护多个配置。
    例如，将 kickstart 配置安装在 `~/.config/nvim-kickstart` 下，然后创建别名：
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    使用 `nvim-kickstart` 别名运行 Neovim 时，它将使用替代配置目录及对应的本地目录 `~/.local/share/nvim-kickstart`。
    你可以将此方法应用于任何想尝试的 Neovim 发行版。
* 如果想"卸载"此配置怎么办？
  * 删除配置目录和本地数据目录（例如 `~/.config/nvim` 和 `~/.local/share/nvim`）。
* 为什么 kickstart 的 `init.lua` 是单个文件？拆分成多个文件不是更好吗？
  * kickstart 的主要目的是作为教学工具和参考配置，方便他人 `git clone` 作为自己配置的基础。
    随着你学习 Neovim 和 Lua 的深入，可以考虑将 `init.lua` 拆分成更小的部分。
    一个在保持相同功能的同时进行了拆分的 fork 在这里：
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * 相关讨论可以在这里找到：
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### 安装方案

以下是一些特定操作系统的 Neovim 和依赖项安装说明。

安装完所有依赖后，继续执行[安装 Kickstart](#安装-kickstart) 步骤。

#### Windows 安装

<details><summary>使用 Microsoft C++ 生成工具和 CMake 的 Windows</summary>
Kickstart 的默认配置仅对 `telescope-fzf-native.nvim` 需要 make。
如果 `make` 不可用，该插件会被跳过。

推荐：安装 `make`（参见下面的 chocolatey 部分）。

如果想要纯 CMake 方式，请在两处修改 `init.lua`：

1. 当 `cmake` 可用时包含 `telescope-fzf-native.nvim`：

```lua
if vim.fn.executable 'make' == 1 or vim.fn.executable 'cmake' == 1 then
  table.insert(plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
end
```

2. 在 `PackChanged` 钩子中，当 `make` 不可用时使用 CMake：

```lua
if name == 'telescope-fzf-native.nvim' then
  if vim.fn.executable 'make' == 1 then
    run_build(name, { 'make' }, ev.data.path)
  elseif vim.fn.executable 'cmake' == 1 then
    run_build(name, { 'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release' }, ev.data.path)
    run_build(name, { 'cmake', '--build', 'build', '--config', 'Release', '--target', 'install' }, ev.data.path)
  end
  return
end
```

查看 `telescope-fzf-native` 文档了解[构建细节](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)。
</details>
<details><summary>使用 chocolatey 安装 gcc/make 的 Windows</summary>
另一种方式，可以安装 gcc 和 make，无需修改配置。
最简单的方法是使用 choco：

1. 安装 [chocolatey](https://chocolatey.org/install)
   按照页面说明或使用 winget，
   在 **管理员** 模式下运行 cmd：
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. 使用 choco 安装所有依赖，退出上一个 cmd
   打开新的窗口（以便 choco 路径生效），在 **管理员** 模式下运行 cmd：
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make tree-sitter
```
</details>
<details><summary>WSL（适用于 Linux 的 Windows 子系统）</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```
</details>

#### Linux 安装
<details><summary>Ubuntu 安装步骤</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```
</details>
<details><summary>Debian 安装步骤</summary>

```
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl

# 现在安装 nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# 使其在 /usr/local/bin 中可用（发行版安装到 /usr/bin）
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora 安装步骤</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find tree-sitter-cli unzip neovim
```
</details>
<details><summary>Arch 安装步骤</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd tree-sitter-cli unzip neovim
```
</details>

### 替代 Neovim 安装方法

在某些系统上，Neovim 推荐的[包管理器安装方式](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
版本可能明显滞后。如果遇到这种情况，可以选择以下已知能快速提供最新 Neovim 版本的方法。
这些方法因其受欢迎且能轻松安装和更新到最新版本而被选取。
更多细节请参阅[这里](https://github.com/nvim-lua/kickstart.nvim/issues/1583)的讨论。

<details><summary>Bob</summary>

[Bob](https://github.com/MordechaiHadad/bob) 是一个跨平台的 Neovim 版本管理器。
只需安装 [rustup](https://rust-lang.github.io/rustup/installation/other.html)，
然后运行以下命令：

```bash
rustup default stable
rustup update stable
cargo install bob-nvim
bob use stable
```

</details>

<details><summary>Homebrew</summary>

[Homebrew](https://brew.sh) 是 Mac 和 Linux 上流行的包管理器。
使用 [`brew install`](https://formulae.brew.sh/formula/neovim) 即可安装。

</details>

<details><summary>Flatpak</summary>

Flatpak 是一个应用包管理器，允许开发者一次打包即可在所有 Linux 系统上使用。
只需[安装 flatpak](https://flatpak.org/setup/) 并
设置 [flathub](https://flathub.org/setup) 即可[安装 neovim](https://flathub.org/apps/io.neovim.nvim)。

</details>

<details><summary>asdf 和 mise-en-place</summary>

[asdf](https://asdf-vm.com/) 和 [mise](https://mise.jdx.dev/) 是工具版本管理器，
主要用于项目特定的工具版本管理。但两者也支持在用户空间中全局管理工具：

<details><summary>mise</summary>

[安装 mise](https://mise.jdx.dev/getting-started.html)，然后运行：

```bash
mise plugins install neovim
mise use neovim@stable
```

</details>

<details><summary>asdf</summary>

[安装 asdf](https://asdf-vm.com/guide/getting-started.html)，然后运行：

```bash
asdf plugin add neovim
asdf install neovim stable
asdf set neovim stable --home
asdf reshim neovim
```

</details>

</details>
