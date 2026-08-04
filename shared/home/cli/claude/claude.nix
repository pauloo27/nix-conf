{ pkgs, config, ... }:
let
  json = (pkgs.formats.json { }).generate;
in
{
  home.file.".claude/CLAUDE.md".source = ./global.md;

  home.file.".claude/agents".source = ./agents;
  home.file.".claude/skills".source = ./skills;

  home.file.".claude/statusline-command.sh" = {
    source = ./statusline-command.sh;
    executable = true;
  };

  home.file.".claude/settings.json".source = json "claude-settings.json" {
    "$schema" = "https://json.schemastore.org/claude-code-settings.json";

    statusLine = {
      type = "command";
      command = "bash ${config.home.homeDirectory}/.claude/statusline-command.sh";
    };

    enabledPlugins = {
      "typescript-lsp@claude-plugins-official" = true;
      "gopls-lsp@claude-plugins-official" = true;
      "frontend-design@claude-plugins-official" = true;
      "rust-analyzer-lsp@claude-plugins-official" = true;
      "atlassian@claude-plugins-official" = true;
    };

    effortLevel = "medium";
    tui = "fullscreen";
    editorMode = "vim";
    verbose = false;
    agentPushNotifEnabled = true;
    skipAutoPermissionPrompt = true;

    voice = {
      enabled = true;
      mode = "hold";
    };
  };
}
