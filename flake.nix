{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake lock --update-input [input]
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # https://github.com/NixOS/nixpkgs
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR

    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/home-manager
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/nixos-generators

    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/lib
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/flake

    stylix.url = "github:danth/stylix"; # https://github.com/danth/stylix

    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/wamserma/flake-programs-sqlite

    nix-flatpak.url = "github:gmodena/nix-flatpak/tags/v0.4.1"; # https://github.com/gmodena/nix-flatpak/tags
  };

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  #$ nix flake check --keep-going
  #$ nix flake show
  #$ nix fmt [./folder] [./file.nix]
  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;

    snowfall = {
      namespace = "dafitt";
      meta = {
        name = "dafitt-desktop-flake";
        title = "Dafitt's desktop flake";
      };
    };

    channels-config = {
      allowUnfree = true;
    };

    overlays = with inputs; [
      nur.overlay
    ];

    systems.modules.nixos = with inputs; [
      stylix.nixosModules.stylix
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    templates = import ./templates { };

    # [Generic outputs](https://snowfall.org/guides/lib/generic/)
    outputs-builder = channels: {
      formatter = channels.nixpkgs.nixpkgs-fmt; # [nix fmt](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html)
    };
  };

  description = "Dafitt's desktop flake";
}
