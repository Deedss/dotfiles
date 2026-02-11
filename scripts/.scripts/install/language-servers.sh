#!/bin/bash
#### INSTALL LANGUAGE SERVERS ######

install-rust-lsp() {
  rustup component add rust-analyzer
}

install-cpp-lsp() {
  ## Clangd lsp
  doas dnf install clang-tools-extra
  ## Debug tool
  local API_URL="https://api.github.com/repos/vadimcn/codelldb/releases/latest"
  local INSTALL_DIR="$HOME/Software/language-servers/codelldb"
  local LATEST_VERSION=$(curl -s "$API_URL" | jq -r '.tag_name')
  local DOWNLOAD_URL="https://github.com/vadimcn/codelldb/releases/download/${LATEST_VERSION}/codelldb-linux-x64.vsix"

  rm -rf "$INSTALL_DIR"
  mkdir -p "$INSTALL_DIR"
  curl -L "$DOWNLOAD_URL" -o "/tmp/codelldb-linux-x64.vsix"
  unzip "/tmp/codelldb-linux-x64.vsix" -d "$INSTALL_DIR"
}

install-cmake-lsp() {
  pip install cmake-language-server cmakelint cmakelang
}

install-python-lsp() {
  pip install python-lsp-server ruff debugpy

}

install-lua-lsp() {
  local API_URL="https://api.github.com/repos/LuaLS/lua-language-server/releases/latest"
  local INSTALL_DIR="$HOME/Software/language-servers/lua-language-server"
  local LATEST_VERSION=$(curl -s "$API_URL" | jq -r '.tag_name')
  local DOWNLOAD_URL="https://github.com/LuaLS/lua-language-server/releases/download/$LATEST_VERSION/lua-language-server-${LATEST_VERSION}-linux-x64.tar.gz"

  rm -rf "$INSTALL_DIR"
  mkdir -p "$INSTALL_DIR"
  curl -L "$DOWNLOAD_URL" -o "/tmp/lua-language-server-linux-x64.tar.gz"
  tar -xzf "/tmp/lua-language-server-linux-x64.tar.gz" -C "$INSTALL_DIR"
}
