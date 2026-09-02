{
  description = "sanya's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      fenix,
      firefox-nightly,
      treefmt-nix,
      chaotic,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

      nightlyMuslToolchain = fenix.packages.${system}.combine [
        fenix.packages.${system}.latest.rustc
        fenix.packages.${system}.latest.cargo
        fenix.packages.${system}.latest.rust-std
        fenix.packages.${system}.targets.x86_64-unknown-linux-musl.latest.rust-std
        fenix.packages.${system}.latest.rust-src
      ];

      overlays = import ./modules/overlays.nix { inherit nightlyMuslToolchain; } ++ [
        firefox-nightly.overlays.default
      ];
    in
    {
      nixosConfigurations.nyx = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hardware-configuration.nix
          ./modules/boot.nix
          ./modules/nix.nix
          ./modules/networking.nix
          ./modules/users.nix
          ./modules/desktop.nix
          ./modules/audio.nix
          ./modules/fonts.nix
          ./modules/power.nix
          ./modules/packages.nix
          ./modules/misc.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sanya = import ./home/home.nix;
            home-manager.backupFileExtension = "bak";
          }
        ];
      };

      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatting = treefmtEval.config.build.check self;
    };
}
