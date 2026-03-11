{
  programs.neovim.extraLuaConfig = builtins.readFile ./auto-import.lua;
}
