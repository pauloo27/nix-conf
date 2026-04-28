{ unstable, ... }:
{
  home.packages = [ unstable.voxtype-onnx ];
  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "/usr/lib64/alsa-lib:/usr/lib/alsa-lib";
  };
}
