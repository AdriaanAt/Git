{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome.extensions.just-perfection;
in
{
  options.dafitt.desktops.gnome.extensions.just-perfection = with types; {
    enable = mkBoolOpt config.dafitt.desktops.gnome.extensions.enable "Enable Gnome extension 'just-perfection'.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ just-perfection ];

    dconf.settings = {
      "org/gnome/shell/extensions/just-perfection" = {
        #top-panel-position = 1; # bottom
        animation = 4;
        dash = false;
        double-super-to-appgrid = false;
        window-demands-attention-focus = true;
      };
    };
  };
}
