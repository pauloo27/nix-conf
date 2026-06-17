{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "fjapi";
      runtimeInputs = [ pkgs.curl pkgs.jq ];
      text = builtins.readFile ./fjapi.sh;
    })
  ];
}
