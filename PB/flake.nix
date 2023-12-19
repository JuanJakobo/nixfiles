{
  description = "Flake for Pocketbook Dev Enviroment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            cmake
            ncurses5
            conan
            ];
        shellHook = ''
            export PATH="$PATH:/home/juan/Documents/SDK/SDK_6.3.0/SDK-B288/usr/bin";
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [pkgs.ncurses5 pkgs.ncurses6]}:$LD_LIBRARY_PATH;
        '';
        };
      });
}
