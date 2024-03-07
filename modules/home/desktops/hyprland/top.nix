{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.top;
in
{
  options.custom.desktops.hyprland.top = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable a top for hyprland";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "float, title:^btop$, class:kitty"
        "size 90% 90%, title:^btop$"
        "minsize 800 530, title:^btop$"
        "center, title:^btop$"
      ];
    };
  };
}
