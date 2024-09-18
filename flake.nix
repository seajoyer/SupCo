{
  description = "Wrapper flake for Machine_units and Argument_search projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

    # Referencing subdirectories on GitHub
    argument_search.url = "github:seajoyer/SupCo?dir=Argument_search";
    machine_units.url = "github:seajoyer/SupCo?dir=Machine_units";
  };

  outputs = { self, nixpkgs, flake-utils, argument_search, machine_units }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Get the outputs of the argument_search and machine_units flakes
        argument_search_outputs = argument_search.outputs { self = argument_search; nixpkgs = nixpkgs; flake-utils = flake-utils; };
        machine_units_outputs = machine_units.outputs { self = machine_units; nixpkgs = nixpkgs; flake-utils = flake-utils; };
      in {
        packages = {
          # Expose packages for both projects
          argument_search = argument_search_outputs.packages.${system}.default;
          machine_units_cpp = machine_units_outputs.packages.${system}.mch_uns-cpp;
          machine_units_py = machine_units_outputs.packages.${system}.mch_uns-py;
        };

        apps = {
          # Expose apps for both projects
          argument_search = argument_search_outputs.apps.${system}.default;
          machine_units_cpp = machine_units_outputs.apps.${system}.mch_uns-cpp;
          machine_units_py = machine_units_outputs.apps.${system}.mch_uns-py;
        };

        devShells = {
          # Expose devShells for both projects
          argument_search = argument_search_outputs.devShells.${system}.default;
          machine_units = machine_units_outputs.devShells.${system}.default;
        };
      });
}
