{ pkgs, ... }:
{
  imports = [
    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/bash.nix
    ../../shared/home/cli/git.nix
    ../../shared/home/cli/tmux.nix
    ../../shared/home/cli/claude/claude.nix

    # infra
    ../../shared/home/infra.nix

    # apps
    ../../shared/home/apps/ghostty.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/nix.nix
    ../../shared/home/editor/nvim/langs/js_and_ts.nix
    ../../shared/home/editor/nvim/langs/tailwindcss.nix
  ];

  # fonts.nix is not importable here (its fontconfig block is linux-only), and there
  # is no fontconfig to reject the non-mono face either, so ship the mono one alone.
  home.packages = [
    (pkgs.runCommand "symbols-nerd-font-mono" { } ''
      mkdir -p $out/share/fonts/truetype
      cp ${pkgs.nerd-fonts.symbols-only}/share/fonts/truetype/NerdFonts/Symbols/SymbolsNerdFontMono-Regular.ttf \
        $out/share/fonts/truetype/
    '')
  ];

  # linux.nix does this for the other hosts, but it is not importable here.
  # zsh.nix needs $XDG_CONFIG_HOME to be exported
  xdg.enable = true;

  # nix-darwin's /etc/zshenv is disabled, so darwin-rebuild needs to be found here.
  home.sessionPath = [
    "/run/current-system/sw/bin"
  ];

  home.stateVersion = "26.05";
  home.username = "paulo";
  home.homeDirectory = "/Users/paulo";
}
