variant:
{ pkgs, voxtype, ... }:
let
  voxtypePkg = voxtype.packages.${pkgs.stdenv.hostPlatform.system}.${variant};
  # The system PipeWire libs aren't visible to the nix-linked voxtype binary.
  # Wrap so ALSA can find the pipewire plugin and its dependencies, without
  # polluting LD_LIBRARY_PATH for any other nix binary. ALSA_PLUGIN_DIR is a
  # SINGLE directory (not a colon-separated search path), so pick the right one
  # at runtime to keep this shared module host-agnostic: Fedora uses
  # /usr/lib64/alsa-lib, Arch uses /usr/lib/alsa-lib.
  voxtypeWrapped = pkgs.symlinkJoin {
    name = "voxtype-wrapped";
    paths = [ voxtypePkg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/voxtype \
        --run 'for d in /usr/lib64/alsa-lib /usr/lib/alsa-lib; do [ -e "$d/libasound_module_pcm_pipewire.so" ] && export ALSA_PLUGIN_DIR="$d" && break; done' \
        --prefix LD_LIBRARY_PATH : /usr/lib64:/usr/lib
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
