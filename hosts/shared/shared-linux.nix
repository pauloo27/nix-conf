{ ... }: {
  # Linux-specific configuration
  # Don't import this on macOS hosts

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "$HOME/desktop";
    download = "$HOME/downloads";
    templates = "$HOME/documents/templates";
    publicShare = "$HOME/documents/public";
    documents = "$HOME/documents";
    music = "$HOME/medias/music";
    pictures = "$HOME/medias/pictures";
    videos = "$HOME/medias/videos";
  };
}
