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
  };

  outputs = { self, nixpkgs, home-manager, fenix, firefox-nightly, ... }:
    let
      system = "x86_64-linux";

      nightlyMuslToolchain = fenix.packages.${system}.combine [
        fenix.packages.${system}.latest.rustc
        fenix.packages.${system}.latest.cargo
        fenix.packages.${system}.latest.rust-std
        fenix.packages.${system}.targets.x86_64-unknown-linux-musl.latest.rust-std
        fenix.packages.${system}.latest.rust-src
      ];

      overlays = import ./modules/overlays.nix { inherit nightlyMuslToolchain; }
        ++ [ firefox-nightly.overlays.default ];
    in {
      nixosConfigurations.nyx = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { nixpkgs.overlays = overlays; }
          ./configuration.nix
          ./services.nix
          ./hardware-configuration.nix
          ./modules/boot.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sanya = import ./home/home.nix;
          }
        ];
      };
    };
}
