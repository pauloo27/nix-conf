{ lib, ... }:
{
  home.activation.installClaudeCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! command -v claude &> /dev/null; then
      echo "Claude Code CLI not found, installing via official installer..."
      curl -fsSL https://claude.ai/install.sh | bash
      echo "Claude Code CLI installed."
    fi
  '';
}
