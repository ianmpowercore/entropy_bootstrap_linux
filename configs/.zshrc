# Minimal .zshrc for entropy_bootstrap_linux
# Copy to $HOME/.zshrc via setup.sh

# Source existing bash aliases if present
if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

# Prompt
export PS1="%n@%m:%~%# "

# Add user-local bin to PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
