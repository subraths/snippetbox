# Neovim Configuration for Go Development

This Neovim configuration is optimized for Go development, particularly for working on the snippetbox project. It provides a modern, feature-rich development environment with excellent Go language support.

## Features

### 🚀 Modern Plugin Management
- **Lazy.nvim** for fast and efficient plugin loading
- Automatic plugin updates and health checks

### 🎨 Beautiful UI
- **Tokyo Night** colorscheme with dark theme optimized for coding
- **Lualine** statusline with git integration and LSP status
- **Bufferline** for better buffer management
- **Neo-tree** file explorer with git status
- **Which-key** for discoverable keybindings
- **Noice** for enhanced UI components

### 🔧 Go Development Tools
- **gopls** language server with full LSP support
- **go.nvim** for Go-specific features and commands
- **gopher.nvim** for struct tag generation
- **neotest-go** for running and debugging tests
- **nvim-dap-go** for debugging with Delve
- Auto-formatting with **gofumpt** and **goimports**
- **golangci-lint** integration for linting

### 📝 Code Intelligence
- **nvim-cmp** for autocompletion with LSP support
- **LuaSnip** for code snippets
- **Treesitter** for syntax highlighting and code understanding
- Automatic bracket/quote pairing
- Smart comments with context awareness

### 🔍 Search and Navigation
- **Telescope** for fuzzy finding files, grep, and more
- **gitsigns** for git integration in the editor
- **lazygit** integration for git operations
- Jump to definitions, references, and symbols

### 🛠️ Development Workflow
- **conform.nvim** for code formatting
- **nvim-lint** for linting integration
- **trouble.nvim** for diagnostics and error management
- **todo-comments** for highlighting TODO/FIXME comments
- Format-on-save for Go files

## Installation

### Prerequisites

Make sure you have the following installed:
- Neovim 0.9.0 or later
- Git
- Go 1.21 or later
- Node.js (for some LSP servers)
- ripgrep (for telescope grep)
- fd (for telescope file finding)

### Using the Configuration

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Copy this configuration**:
   ```bash
   cp -r .config/nvim ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Install plugins** (this happens automatically on first run):
   The configuration will automatically install all plugins and LSP servers.

5. **Install additional tools**:
   ```bash
   # Go tools (will be installed by Mason)
   go install golang.org/x/tools/gopls@latest
   go install github.com/go-delve/delve/cmd/dlv@latest
   go install mvdan.cc/gofumpt@latest
   go install golang.org/x/tools/cmd/goimports@latest
   ```

## Key Bindings

### Leader Key
- Leader key is set to `<Space>`

### Essential Bindings
- `<Space>e` - Toggle file explorer
- `<Space>ff` - Find files
- `<Space>fg` - Find git files
- `<Space>/` - Live grep search
- `<Space>gg` - Open LazyGit

### Go-specific Bindings
- `<Space>gr` - Run Go program
- `<Space>gt` - Run Go tests
- `<Space>gc` - Show Go coverage
- `<Space>gf` - Format Go code
- `<Space>gi` - Organize Go imports
- `<Space>gd` - Go documentation

### LSP Bindings
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover documentation
- `<Space>ca` - Code actions
- `<Space>rn` - Rename symbol
- `[d` / `]d` - Navigate diagnostics

### Debugging
- `<Space>db` - Toggle breakpoint
- `<Space>dc` - Continue debugging
- `<Space>di` - Step into
- `<Space>do` - Step out
- `<Space>dO` - Step over

### Testing
- `<Space>tt` - Run test file
- `<Space>tr` - Run nearest test
- `<Space>ts` - Toggle test summary

### Git Integration
- `<Space>gh*` - Git hunk operations (stage, reset, preview)
- `<Space>gb` - Git blame
- `<Space>gl` - Git log
- `]h` / `[h` - Navigate git hunks

## Project Structure

```
.config/nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua     # Autocommands and file type settings
│   │   ├── keymaps.lua      # Key bindings
│   │   └── options.lua      # Neovim options and settings
│   └── plugins/
│       ├── coding.lua       # Syntax highlighting and editing
│       ├── colorscheme.lua  # Theme configuration
│       ├── completion.lua   # Autocompletion setup
│       ├── editor.lua       # File tree and navigation
│       ├── git.lua          # Git integration
│       ├── go.lua           # Go-specific tools
│       ├── linting.lua      # Formatting and linting
│       ├── lsp.lua          # Language server configuration
│       ├── telescope.lua    # Fuzzy finder
│       └── ui.lua           # UI improvements
```

## Go Development Workflow

### Starting Development
1. Open the project: `nvim .`
2. Use `<Space>e` to open the file explorer
3. Navigate to files using `<Space>ff` or the file explorer

### Writing Code
- LSP provides real-time error checking and autocompletion
- Use `K` to view documentation for functions/types
- `gd` to jump to definitions, `gr` to find references

### Testing
- Use `<Space>tt` to run tests in the current file
- Use `<Space>tr` to run the test under cursor
- Test results appear in a separate panel

### Debugging
- Set breakpoints with `<Space>db`
- Start debugging with `<Space>dc`
- Step through code with `<Space>di`, `<Space>do`, `<Space>dO`

### Git Operations
- Use `<Space>gg` for LazyGit interface
- Stage/unstage hunks with `<Space>ghs`/`<Space>ghr`
- View git blame with `<Space>gb`

## Customization

### Adding Your Own Plugins
Create a new file in `lua/plugins/` and add your plugin specifications:

```lua
-- lua/plugins/my-plugins.lua
return {
  {
    "author/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```

### Modifying Keybindings
Edit `lua/config/keymaps.lua` to add or modify key bindings.

### Changing Theme
Edit `lua/plugins/colorscheme.lua` to change the colorscheme or add alternatives.

## Troubleshooting

### LSP Not Working
1. Check if gopls is installed: `:LspInfo`
2. Install missing servers: `:Mason`
3. Restart LSP: `:LspRestart`

### Plugins Not Loading
1. Check plugin status: `:Lazy`
2. Update plugins: `:Lazy update`
3. Check for errors: `:checkhealth`

### Performance Issues
1. Check startup time: `nvim --startuptime startup.log`
2. Profile plugins: `:Lazy profile`

## Support

This configuration is specifically tailored for the snippetbox Go project. For general Neovim help:
- `:help` - Built-in help system
- `:checkhealth` - Check configuration health
- `:Lazy` - Plugin manager interface
- `:Mason` - LSP server manager

## License

This configuration is provided as-is for the snippetbox project. Feel free to modify and adapt it to your needs.