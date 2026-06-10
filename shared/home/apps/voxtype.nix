variant:
{ pkgs, voxtype, ... }:
let
  voxtypePkg = voxtype.packages.${pkgs.stdenv.hostPlatform.system}.${variant};
  # Arch's PipeWire libs aren't visible to the nix-linked voxtype binary.
  # Wrap so ALSA can find the pipewire plugin and its dependencies, without
  # polluting LD_LIBRARY_PATH for any other nix binary.
  voxtypeWrapped = pkgs.symlinkJoin {
    name = "voxtype-arch-wrapped";
    paths = [ voxtypePkg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/voxtype \
        --set ALSA_PLUGIN_DIR /usr/lib/alsa-lib \
        --prefix LD_LIBRARY_PATH : /usr/lib
    '';
  };
in
{
  programs.voxtype = {
    enable = true;
    package = voxtypeWrapped;
    model.name = "base.en";
    settings = {
      hotkey.enabled = false;
      whisper.language = "en";
    };
  };
}
