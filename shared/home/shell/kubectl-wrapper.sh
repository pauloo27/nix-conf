# kubectl wrapper: lazy-load completion only.
# Context selection is done via $KUBECONFIG (merged list of per-cluster
# files under ~/.kube/configs/, or a single file for a scoped shell).

if [ -d "$HOME/.kube/configs" ]; then
  _extra=$(find "$HOME/.kube/configs" -type f -print0 2>/dev/null | tr '\0' ':')
  export KUBECONFIG="$HOME/.kube/config:${_extra%:}"
  unset _extra
fi

kubectl() {
  if [ -z "$_KUBECTL_COMPLETION_LOADED" ]; then
    if [ -n "$ZSH_VERSION" ]; then
      source <(command kubectl completion zsh)
    elif [ -n "$BASH_VERSION" ]; then
      source <(command kubectl completion bash)
    fi
    export _KUBECTL_COMPLETION_LOADED=1
  fi
  command kubectl "$@"
}
