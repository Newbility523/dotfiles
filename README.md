# Dotfiles

Personal dotfiles managed with Git, symlinks, and an install script.

## Layout

```text
dotfiles/
├── README.md
├── install.sh
├── bash/
│   ├── .bash_profile
│   └── .bashrc
├── zsh/
│   └── .zshrc
├── nvim/
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/
├── tmux/
│   └── .tmux.conf
├── git/
│   ├── .gitconfig
│   └── .gitconfig.local.example
├── common/
├── mac/
├── linux/
├── wsl/
└── scripts/
```

The repository stores the source files. Your home directory uses symbolic links:

```text
~/.bashrc              -> ~/dotfiles/bash/.bashrc
~/.bash_profile        -> ~/dotfiles/bash/.bash_profile
~/.zshrc               -> ~/dotfiles/zsh/.zshrc
~/.tmux.conf           -> ~/dotfiles/tmux/.tmux.conf
~/.gitconfig           -> ~/dotfiles/git/.gitconfig
~/.config/nvim         -> ~/dotfiles/nvim/.config/nvim
```

## Install

Clone the repository:

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Run the installer for your platform:

```bash
chmod +x install.sh
./install.sh linux
```

Supported profiles:

```bash
./install.sh mac
./install.sh linux
./install.sh wsl
```

Windows-specific configuration:

```powershell
.\install-windows.ps1
```

This creates a Startup shortcut for:

```text
autohotkey/mac-style-alt-copy-paste.ahk
```

Optional system-wide keyboard remap:

```powershell
# Run PowerShell as Administrator.
.\windows\register-left-alt-win-swap.ps1
.\windows\unregister-left-alt-win-swap.ps1
```

The register script swaps Left Alt and Left Windows through the Windows `Scancode Map` registry value. Restart Windows after registering or unregistering.

If a target file already exists, the Unix installer moves it to a timestamped backup before creating the symlink.

## Local Secrets

Do not commit private machine-specific values.

Use `~/.gitconfig.local` for local identity, company settings, or private includes. It is ignored by Git. Start from:

```bash
cp git/.gitconfig.local.example ~/.gitconfig.local
```

Never commit:

- `.ssh/`
- `.env`
- API tokens
- npm tokens
- GitHub tokens
- company internal credentials or repository URLs
