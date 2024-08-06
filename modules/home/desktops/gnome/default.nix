{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome;
  osCfg = osConfig.dafitt.desktops.gnome or null;
in
{
  options.dafitt.desktops.gnome = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable Gnome home configuration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dconf-editor
      gnome-tweaks
    ];

    dconf.settings = {
      #$ dconf watch /
      "org/gnome/desktop/input-sources" = {
        sources = [ [ "xkb" "de" ] ];
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };
      "org/gnome/desktop/notifications" = {
        show-in-lock-screen = false;
      };
      "org/gnome/desktop/privacy" = {
        recent-files-max-age = 1; # File History
        remove-old-temp-files = true;
        remove-old-trash-files = true;
      };
      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true;
      };

      # Window manager
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        num-workspaces = 10;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
        visual-bell = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>x" ];
        maximize = [ ];
        toggle-maximized = [ "<Super>a" ];
        toggle-fullscreen = [ "<Super>f" ];
        toggle-above = [ "<Super>b" ];
        minimize = [ "<Super>y" ];
        show-desktop = [ "<Super>d" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        move-to-workspace-10 = [ "<Shift><Super>0" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-10 = [ "<Super>0" ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        unmaximize = [ ];
        toggle-overview = [ "<Shift><Super>y" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kitty";
        name = "Terminal";
      };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        toggle-application-view = [ ];
      };
      "org/gnome/shell/window-switcher" = {
        current-workspace-only = false;
      };
      "org/gnome/gnome-session" = {
        auto-save-session = true;
        logout-prompt = false;
        idle-delay = 0;
      };
    };
  };
}
