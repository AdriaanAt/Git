{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.office;
  osCfg = osConfig.dafitt.office or null;
in
{
  options.dafitt.office = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the office suite";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      cantarell-fonts
      hunspell # Spell checking
      hunspellDicts.de_DE
      hunspellDicts.en_US-large
      inter # font
      liberation_ttf
      libreoffice-fresh # office suite
      pandoc # document converter
      pdfarranger # merge split rotate crop rearrange pdf pages
      ghostscript # pdf tools
    ];

    services.flatpak.packages = [
      "de.bund.ausweisapp.ausweisapp2"
      "com.github.rajsolai.textsnatcher"
      "org.x.Warpinator"
    ];

    fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env

    # pdf reader
    programs.zathura = {
      enable = true;
    };
  };
}
