{
  description = "Crafting solver for Final Fantasy XIV Online";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system} = rec {
        raphael-xiv = nixpkgs.legacyPackages.${system}.callPackage ./package.nix { };
        default = raphael-xiv;
      };
    };
}
