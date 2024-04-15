{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager.gdm;
in
{
  options.dafitt.displayManager.gdm = with types; {
    enable = mkBoolOpt (config.dafitt.displayManager.enable == "gdm") "Enable gdm as the login/display manager";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    programs.dconf.profiles.gdm.databases = [{
      settings = {
        "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;
      };
    }];
  };
}
