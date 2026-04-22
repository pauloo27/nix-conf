{ unstable, ... }:
{
  home.packages = [ unstable.voxtype-onnx ];
  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "/usr/lib64/alsa-lib:/usr/lib/alsa-lib";
    LD_LIBRARY_PATH = "/usr/lib64:/usr/lib\${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}";
  };
}
