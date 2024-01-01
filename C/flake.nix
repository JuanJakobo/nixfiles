{
  description = "Flake for Pocketbook Dev Enviroment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs_gcc = import (builtins.fetchTarball {
            url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
            }) {};
      in
      {
        devShells.default = pkgs.mkShell {
            pkgs_gcc.gcc;
        };
      });
}
