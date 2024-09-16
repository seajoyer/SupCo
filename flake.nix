{
  description = "Wrapper flake for home work projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    machine-units.url = "path:./Machine_units";
    machine-units.inputs.nixpkgs.follows = "nixpkgs";
    machine-units.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, machine-units }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = machine-units.packages.${system};
        apps = machine-units.apps.${system};
        devShells = machine-units.devShells.${system};
      }
    );
}
