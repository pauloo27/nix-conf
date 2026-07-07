{ ... }:
{
  programs.starship.settings.kubernetes = {
    disabled = false;
    format = "[$context]($style) ";
    # Default style (yellow) — used by any context that isn't prod/local below,
    # e.g. *-dev, *-int, *-nonprod, or anything unrecognised.
    style = "bold yellow";
    contexts = [
      # Generic patterns: the cluster name is captured from the *live* context
      # at runtime (var_cluster) so no real client/job names ever land in git.
      # Order matters — first match wins.

      # <name>-prod  ->  "<name>:PROD" in a bold red block.
      {
        context_pattern = "(?P<var_cluster>[\\w-]+?)-prod";
        style = "bold fg:black bg:red";
        context_alias = " $var_cluster:PROD ";
      }

      # local k3d cluster.
      {
        context_pattern = "k3d-local-kluster";
        style = "green";
        context_alias = "[local]";
      }

      # <name>-<env>  ->  "<name>:<env>" in the default (yellow) style.
      # Catches -dev, -int, -staging, -nonprod, etc. Keep last so the more
      # specific rules above win first.
      {
        context_pattern = "(?P<var_cluster>[\\w-]+?)-(?P<var_env>[\\w]+)";
        context_alias = "[$var_cluster:$var_env]";
      }
    ];
  };
}
