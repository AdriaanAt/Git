# Documentation: <https://danth.github.io/stylix/index.html>
{ config, pkgs, ... }: {

  stylix = {
    image = ../pkgs/wallhaven-967zyk.jpg;
    polarity = "dark"; # force dark/light theme

    # explore <https://github.com/tinted-theming/base16-schemes>
    # explore grafical <https://vimcolorschemes.com/tinted-theming/base16-vim>
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # catppuccin-mocha
    # material-darker
    # da-one-gray
    # hardcore
    # chalk
    # tokyodark
    # ashes
    # mountain
    # tender
    # base16 <https://github.com/chriskempson/base16/blob/main/styling.md>
    override = {
      # cattppuccin-mocha: but less blue in the background
      # <https://github.com/catppuccin/base16>
      base00 = "1e1e1e"; # base
      base01 = "181818"; # mantle
      base02 = "313232"; # surface0
      base03 = "454748"; # surface1
      base04 = "585b5d"; # surface2 
      base05 = "cdd6d9"; # text
    };

    fonts = {
      sansSerif = config.stylix.fonts.serif;
      serif = {
        package = pkgs.ubuntu_font_family;
        name = "Ubuntu";
        #package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        #name = "FiraCode Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12; # used by applications
        desktop = 10; # used in window titles/bars/widgets elements of the desktop
        popups = 14; # for notifications/popups and in general overlay elements of the desktop
        terminal = 12; # for terminals/text editors
      };
    };
  };
}
