#!/bin/bash

# Neovim Configuration Setup Script for snippetbox
# This script helps set up the nvim configuration for Go development

set -e

echo "🚀 Setting up Neovim configuration for Go development..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if nvim is installed
if ! command -v nvim &> /dev/null; then
    print_error "Neovim is not installed. Please install Neovim 0.9.0 or later."
    echo "Installation options:"
    echo "  - Ubuntu/Debian: sudo apt install neovim"
    echo "  - macOS: brew install neovim"
    echo "  - Arch: sudo pacman -S neovim"
    echo "  - Or download from: https://github.com/neovim/neovim/releases"
    exit 1
fi

# Check nvim version
NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)
print_status "Found Neovim version: $NVIM_VERSION"

# Check if Go is installed
if ! command -v go &> /dev/null; then
    print_warning "Go is not installed. Installing Go is recommended for this configuration."
    echo "Install Go from: https://golang.org/dl/"
else
    GO_VERSION=$(go version | cut -d' ' -f3)
    print_status "Found Go version: $GO_VERSION"
fi

# Check for required tools
print_status "Checking for recommended tools..."

tools=("git" "rg" "fd")
for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        print_success "$tool is installed"
    else
        print_warning "$tool is not installed (recommended for better experience)"
        case $tool in
            "rg")
                echo "  Install with: cargo install ripgrep"
                ;;
            "fd")
                echo "  Install with: cargo install fd-find"
                ;;
        esac
    fi
done

# Backup existing nvim config
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_CONFIG_DIR" ]; then
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Existing Neovim configuration found. Backing up to: $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

# Copy the configuration
print_status "Installing Neovim configuration..."
cp -r ".config/nvim" "$HOME/.config/"
print_success "Configuration files copied to $NVIM_CONFIG_DIR"

# Set proper permissions
chmod -R 755 "$NVIM_CONFIG_DIR"

print_status "Configuration setup complete!"
echo ""
echo "🎉 Next steps:"
echo "1. Start Neovim: nvim"
echo "2. The configuration will automatically install plugins on first run"
echo "3. Run :checkhealth to verify everything is working"
echo "4. See .config/nvim/README.md for detailed usage instructions"
echo ""
echo "📚 Key bindings to get started:"
echo "  <Space>e  - Open file explorer"
echo "  <Space>ff - Find files"
echo "  <Space>/  - Search in files"
echo "  <Space>gg - Open LazyGit"
echo ""
echo "Happy coding! 🚀"