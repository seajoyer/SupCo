{
  description = "Wrapper flake for Machine_units and Argument_search projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    machine-units = {
      url = "path:./Machine_units";
      flake = false;
    };
    argument-search = {
      url = "path:./Argument_search";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, machine-units, argument-search }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        machine-units-flake = import machine-units {
          inherit pkgs system;
          nixpkgs = nixpkgs;
          flake-utils = flake-utils;
        };

        argument-search-flake = import argument-search {
          inherit pkgs system;
          nixpkgs = nixpkgs;
          flake-utils = flake-utils;
        };

      in {
        packages = {
          machine_units-cpp = machine-units-flake.packages.machine_units-cpp;
          machine_units-py = machine-units-flake.packages.machine_units-py;
          argument_search = argument-search-flake.packages.argument_search;
          default = machine-units-flake.packages.default;
        };

        apps = {
          machine_units-cpp = machine-units-flake.apps.machine_units-cpp;
          machine_units-py = machine-units-flake.apps.machine_units-py;
          argument_search = argument-search-flake.apps.argument_search;
          default = machine-units-flake.apps.default;
        };

        devShells = {
          machine_units = machine-units-flake.devShells.default;
          argument_search = argument-search-flake.devShells.default;
          default = machine-units-flake.devShells.default;
        };
      }
    );
}
