{
  description = "Wrapper flake for Machine_units and Argument_search projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    machine-units.url = "path:./Machine_units";
    argument-search.url = "path:./Argument_search";
  };

  outputs = { self, nixpkgs, flake-utils, machine-units, argument-search }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          machine_units-cpp = machine-units.packages.${system}.machine_units-cpp;
          machine_units-py = machine-units.packages.${system}.machine_units-py;
          argument_search = argument-search.packages.${system}.argument_search;
          default = machine-units.packages.${system}.default;
        };

        apps = {
          machine_units-cpp = machine-units.apps.${system}.machine_units-cpp;
          machine_units-py = machine-units.apps.${system}.machine_units-py;
          argument_search = argument-search.apps.${system}.argument_search;
          default = machine-units.apps.${system}.default;
        };

        devShells = {
          machine_units = machine-units.devShells.${system}.default;
          argument_search = argument-search.devShells.${system}.default;
          default = machine-units.devShells.${system}.default;
        };
      }
    );
}
