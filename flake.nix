{
  description = "Crafting solver for Final Fantasy XIV Online";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system} = rec {
        raphael-xiv = nixpkgs.legacyPackages.${system}.callPackage ./package.nix {
          rust-beta = rust-overlay.packages.${system}.rust-beta;
        };
        default = raphael-xiv;
      };
    };
}
