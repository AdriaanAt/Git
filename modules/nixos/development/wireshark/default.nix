{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.wireshark;
in
{
  options.dafitt.development.wireshark = with types; {
    enable = mkBoolOpt config.dafitt.development.enableSuite "Enable wireshark, a network protocol analyzer.";
  };

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
    };
  };
}
