{
  description = "Wrapper flake for Machine_units and Argument_search projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

    machine-units-local.url = "path:./Machine_units";
    machine-units-remote = {
      url = "github:seajoyer/SupCo?dir=Machine_units";
      flake = false;
    };
    machine-units.follows = "machine-units-local";

    argument-search-local.url = "path:./Argument_search";
    argument-search-remote = {
      url = "github:seajoyer/SupCo?dir=Argument_search";
      flake = false;
    };
    argument-search.follows = "argument-search-local";
  };

  outputs = { self, nixpkgs, flake-utils, machine-units, argument-search, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Function to import a flake from a path or fallback to remote
        importFlake = localFlake: remoteFlake:
          if builtins.pathExists (toString localFlake)
          then localFlake
          else import remoteFlake;

        machine-units-flake = importFlake machine-units self.inputs.machine-units-remote;
        argument-search-flake = importFlake argument-search self.inputs.argument-search-remote;
      in {
        packages = {
          machine_units-cpp = machine-units-flake.packages.${system}.machine_units-cpp;
          machine_units-py = machine-units-flake.packages.${system}.machine_units-py;
          argument_search = argument-search-flake.packages.${system}.argument_search;
          default = machine-units-flake.packages.${system}.default;
        };

        apps = {
          machine_units-cpp = machine-units-flake.apps.${system}.machine_units-cpp;
          machine_units-py = machine-units-flake.apps.${system}.machine_units-py;
          argument_search = argument-search-flake.apps.${system}.argument_search;
          default = machine-units-flake.apps.${system}.default or machine-units-flake.apps.${system}.machine_units-cpp;
        };

        devShells = {
          machine_units = machine-units-flake.devShells.${system}.default;
          argument_search = argument-search-flake.devShells.${system}.default;
          default = machine-units-flake.devShells.${system}.default;
        };
      }
    );
}
