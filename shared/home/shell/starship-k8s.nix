{ ... }:
{
  programs.starship.settings.kubernetes = {
    disabled = false;
    format = "[$context]($style) ";
    contexts = [
      {
        context_pattern = "prod-cluster";
        style = "bold fg:black bg:red";
        context_alias = " PROD ";
      }
      {
        context_pattern = "dev-int";
        style = "bold yellow";
        context_alias = "[dev-int]";
      }
      {
        context_pattern = "k3d-local-kluster";
        style = "green";
        context_alias = "[local]";
      }
    ];
  };
}
