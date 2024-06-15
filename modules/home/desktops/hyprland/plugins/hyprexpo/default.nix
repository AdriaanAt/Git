{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprexpo;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprexpo = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.plugins.enable "Enable hyprexpo hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo
      plugins = with pkgs; [ inputs.hyprland-plugins.packages.${system}.hyprexpo ];

      settings.bind = [ "SUPER, acute, hyprexpo:expo, toggle" ]; # can be: toggle, off/disable or on/enable

      extraConfig = ''
        plugin {
          hyprexpo {
            columns = 3
            gap_size = ${toString config.wayland.windowManager.hyprland.settings.general.gaps_in}
            bg_col = rgb(${config.lib.stylix.colors.base04})
            workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true # laptop touchpad, 4 fingers
            gesture_distance = 300 # how far is the "max"
            gesture_positive = false # positive = swipe down. Negative = swipe up.
          }
        }
      '';
    };
  };
}
