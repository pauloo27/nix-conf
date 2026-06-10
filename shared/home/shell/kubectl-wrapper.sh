# kubectl wrapper: lazy-load completion + apply $KUBE_CONTEXT if set.
# Sourced from both bash.nix and zsh.nix — the completion source line
# uses $0-style detection so it loads the right completion for each shell.

kubectl() {
  if [ -z "$_KUBECTL_COMPLETION_LOADED" ]; then
    if [ -n "$ZSH_VERSION" ]; then
      source <(command kubectl completion zsh)
    elif [ -n "$BASH_VERSION" ]; then
      source <(command kubectl completion bash)
    fi
    export _KUBECTL_COMPLETION_LOADED=1
  fi
  if [ -n "$KUBE_CONTEXT" ]; then
    command kubectl --context "$KUBE_CONTEXT" "$@"
  else
    command kubectl "$@"
  fi
}
