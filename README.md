# My dotfiles

This repository contains most of my dotfiles. At least the ones I care about enough to want to persist as I inevitably change computers.

## Note to self

Now that you've forgotten how this is supposed to work, let me remind you.

This is managed with GNU stow. You will need to install it on the system you are on now first.

Once you have stow installed, clone this repository and from it's root directory issue the following command:

```sh
stow --dotfiles */
```

This `--dotfiles` flag will preprocess everything and replace "dot-" with an actual .

Since most of the files here are in fact dot files, without this preprocessing we'd have a folder full of invisible files.

## Warning

Currently if you try to use this `--dotfile` flag on a folder containing a `dot-` folder, stow will break. There is a ticket open on github for it here: https://github.com/aspiers/stow/issues/33

So right now, when you `cd` into a folder that looks empty, make sure you're showing hidden files too.

# Brew
This is the list of all the brew formulea I've installed.

### ansible
Ansible is an open-source software provisioning, configuration management, and application deployment tool.

### awk
AWK is a programming language designed for text processing and data extraction from files.

### aws-sam-cli
The AWS Serverless Application Model (SAM) Command Line Interface (CLI) is a tool for building and testing serverless applications on AWS.

### awscli
The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services from the command line.

### bat
`bat` is a cat clone with syntax highlighting and Git integration.

### bottom
Bottom is a cross-platform graphical process/system monitor with a customizable interface and a multitude of features.

### broot
Broot is a new way to see and navigate directory trees.

### cfn-lint
cfn-lint is a tool for linting and validating AWS CloudFormation templates.

### chafa
Chafa is a command-line utility that converts images to text or Unicode characters.

### chezmoi
Chezmoi is a tool for managing your dotfiles across multiple machines.

### cjbassi/ytop/ytop
YTop is a top-like terminal user interface for container metrics.

### cmake
CMake is an open-source, cross-platform family of tools designed to build, test, and package software.

### colima
Colima is a container runtime that runs on macOS with minimal setup.

### composer
Composer is a tool for dependency management in PHP.

### coreutils
GNU Core Utilities are the basic file, shell, and text manipulation utilities of the GNU operating system.

### d12frosted/emacs-plus/emacs-plus@28
Emacs-plus is a version of the Emacs text editor with additional features and packages.

### deno
Deno is a modern runtime for JavaScript and TypeScript that uses V8 and is built in Rust.

### difftastic
Difftastic is a command-line tool for comparing and reviewing code changes.

### docker
Docker is a set of platform-as-a-service products that use operating-system-level virtualization to deliver software in packages called containers.

### docker-compose
Docker Compose is a tool for defining and running multi-container Docker applications.

### dotenvx/brew/dotenvx
Dotenvx is a tool for managing environment variables across different environments.

### elixir
Elixir is a dynamic, functional language designed for building scalable and maintainable applications.

### exercism
Exercism is a platform for practicing programming languages through coding exercises.

### eza
Eza is a command-line tool for searching and browsing man pages.

### fd
`fd` is a simple, fast, and user-friendly alternative to `find`.

### ffmpegthumbnailer
FFmpegThumbnailer is a lightweight video thumbnailer that can be used to create thumbnails for video files.

### fzf
fzf is a command-line fuzzy finder.

### gcc
GCC is the GNU Compiler Collection, which includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and D.

### git-extras
Git-extras provides a few Git utilities to make your life easier.

### glab
GLab is an open-source GitLab command-line tool.

### glow
Glow is a terminal-based markdown viewer with syntax highlighting and other features.

### gnu-sed
GNU sed is a stream editor for filtering and transforming text.

### gnu-tar
GNU tar is a utility for archiving files.

### go
Go is an open-source programming language designed for building simple, reliable, and efficient software.

### graphviz
Graphviz is a package of open-source tools for drawing graphs specified in DOT language scripts.

### grep
GNU grep is a command-line utility for printing lines that match patterns.

### grunt-cli
Grunt is a JavaScript task runner that helps with automating tasks like minification, compilation, unit testing, and linting.

### helix
Helix is a post-modern modal text editor written in Rust.

### htop
htop is an interactive process viewer for Unix systems.

### hurl
Hurl is a command-line tool for running HTTP requests defined in a simple plain text format.

### imagemagick
ImageMagick is a suite of utilities for displaying, converting, and editing raster image and vector image files.

### jesseduffield/lazygit/lazygit
LazyGit is a simple terminal UI for git commands.

### jq
jq is a lightweight and flexible command-line JSON processor.

### jupyterlab
JupyterLab is a web-based interactive development environment for Jupyter notebooks, code, and data.

### koekeishiya/formulae/skhd
skhd is a simple hotkey daemon for macOS.

### koekeishiya/formulae/yabai
yabai is a tiling window manager for macOS.

### lf
lf is a terminal file manager written in Go.

### libgit2@1.7
libgit2 is a portable, pure C implementation of the Git core methods.

### lnav
lnav is an advanced log file viewer for the small-scale.

### localstack/tap/localstack-cli
LocalStack is a cloud service emulator that runs in a single container on your laptop/desktop.

### luarocks
LuaRocks is a deployment and management system for Lua modules.

### make
GNU Make is a tool for controlling the generation of executables and other non-source files from source files.

### markdown
Markdown is a text-to-HTML conversion tool for web writers.

### midnight-commander
Midnight Commander is a visual file manager for Unix-like operating systems.

### moncho/dry/dry
Dry is a Docker manager for the terminal.

### neovim
Neovim is a refactor of the Vim text editor, focused on extensibility and usability.

### noborus/tap/ov
ov is a command-line tool for managing virtual machines on macOS.

### openjdk
OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition (Java SE).

### parallel
GNU Parallel is a shell tool for executing jobs in parallel.

### pass
Pass is a simple command-line password manager.

### pipx
pipx is a tool to help you install and run Python utilities in isolated environments.

### pngpaste
pngpaste is a command-line utility for pasting PNG images from the clipboard to a file.

### pnpm
pnpm is a fast, disk space-efficient package manager for Node.js.

### poppler
Poppler is a PDF rendering library based on the xpdf-3.0 code base.

### python@3.10
Python 3.10 is the latest version of the Python programming language.

### python@3.8
Python 3.8 is an older version of the Python programming language.

### rename
Rename is a command-line utility for renaming files.

### ripgrep
ripgrep is a line-oriented search tool that recursively searches directories for a regex pattern.

### rust
Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.

### samtay/tui/tetris
Tetris is a terminal-based implementation of the classic Tetris game.

### sd
sd is an intuitive find & replace command-line tool.

### sevenzip
7-Zip is a file archiver with a high compression ratio.

### shellcheck
ShellCheck is a static analysis tool for shell scripts.

### sshs
sshs is a command-line tool for managing SSH connections.

### stow
GNU Stow is a symlink farm manager that makes it easy to keep your environment clean and organized.

### stylua
StyLua is an opinionated code formatter for Lua code.

### termshark
TermShark is a terminal user interface for tshark, the command-line packet capture tool.

### texinfo
Texinfo is a documentation system that uses a single source file to produce both online information and printed output.

### tldr
tldr is a collection of simplified and community-driven man pages.

### tmux
tmux is a terminal multiplexer that lets you switch easily between several programs in one terminal.

### tokei
Tokei is a program that displays statistics about your code.

### wget
GNU Wget is a file retrieval utility that can follow links in HTML, PDF, and other file types.

### wtfutil
WTF is a personal information dashboard for your terminal.

### xh
xh is a friendly and fast tool for sending HTTP requests.

### yazi
Yazi is a command-line tool for formatting and validating YAML files.

### yq
yq is a lightweight and portable command-line YAML processor.

### zoxide
Zoxide is a smarter cd command for your terminal.




