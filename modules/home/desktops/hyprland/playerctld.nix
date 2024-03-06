{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.playerctl;
in
{
  options.custom.desktops.hyprland.playerctl = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable playerctl for hyprland";
  };

  config = mkIf cfg.enable {
    # playerctl (media control) daemon
    services.playerctld.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = (lib.optionals config.services.playerctld.enable [
        ", XF86AudioPlay, exec, ${config.services.playerctld.package}/bin/playerctl play-pause"
        ", XF86AudioPause, exec, ${config.services.playerctld.package}/bin/playerctl play-pause"
        ", XF86AudioStop, exec, ${config.services.playerctld.package}/bin/playerctl stop"
        ", XF86AudioNext, exec, ${config.services.playerctld.package}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${config.services.playerctld.package}/bin/playerctl previous"
        "CTRL, XF86AudioRaiseVolume, exec, ${config.services.playerctld.package}/bin/playerctl position 1+"
        "CTRL, XF86AudioLowerVolume, exec, ${config.services.playerctld.package}/bin/playerctl position 1-"
        "ALT, XF86AudioNext, exec, ${config.services.playerctld.package}/bin/playerctld shift"
        "ALT, XF86AudioPrev, exec, ${config.services.playerctld.package}/bin/playerctld unshift"
        "ALT, XF86AudioPlay, exec, systemctl --user restart playerctld"
      ]);
    };
  };
}
