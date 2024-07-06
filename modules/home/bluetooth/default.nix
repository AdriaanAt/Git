{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bluetooth;
  osCfg = osConfig.dafitt.bluetooth or null;
in
{
  options.dafitt.bluetooth = with types;{
    enable = mkBoolOpt (osCfg.enable or false) "Enable a gui for bluetooth.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = optionals config.dafitt.desktops.hyprland.pyprland.enable
        [ "SUPER_ALT, B, exec, ${pkgs.pyprland}/bin/pypr toggle bluetooth" ];
      windowrulev2 = [ "float, class:io.github.kaii_lb.Overskride" ];
    };

    dafitt.desktops.hyprland.pyprland.scratchpads.bluetooth = {
      animation = "fromRight";
      command = "${pkgs.overskride}/bin/overskride";
      class = "io.github.kaii_lb.Overskride";
      size = "40% 70%";
      margin = "2%";
      lazy = true;
    };
  };
}
