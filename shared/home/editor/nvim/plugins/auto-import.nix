{
  programs.neovim.initLua = builtins.readFile ./auto-import.lua;
}
