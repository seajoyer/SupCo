{
  description = "Wrapper flake for home work projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    machine-units = {
      url = "github:seajoyer/SupCo?dir=Machine_units";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    argument-search = {
      url = "github:seajoyer/SupCo?dir=Argument_search";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vector-structure = {
      url = "github:seajoyer/SupCo?dir=Vector_structure";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    interpolation = {
      url = "github:seajoyer/SupCo?dir=Interpolation";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, machine-units, argument-search, vector-structure, interpolation }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          machine_units-cpp = machine-units.packages.${system}.machine_units-cpp;
          machine_units-py  = machine-units.packages.${system}.machine_units-py;
          argument_search = argument-search.packages.${system}.argument_search;
          vector_structure = vector-structure.packages.${system}.vector_structure;
          interpolation-cpp = interpolation.packages.${system}.interpolation-cpp;
          interpolation-py  = interpolation.packages.${system}.interpolation-py;
          default = machine-units.packages.${system}.default;
        };

        apps = {
          machine_units-cpp = machine-units.apps.${system}.machine_units-cpp;
          machine_units-py  = machine-units.apps.${system}.machine_units-py;
          argument_search = argument-search.apps.${system}.argument_search;
          vector_structure = vector-structure.apps.${system}.vector_structure;
          interpolation-cpp = interpolation.apps.${system}.interpolation-cpp;
          interpolation-py  = interpolation.apps.${system}.interpolation-py;
          default = machine-units.apps.${system}.default or machine-units.apps.${system}.machine_units-cpp;
        };

        devShells = {
          machine_units = machine-units.devShells.${system}.default;
          argument_search = argument-search.devShells.${system}.default;
          vector_structure = vector-structure.devShells.${system}.default;
          interpolation = interpolation.devShells.${system}.default;
          default = machine-units.devShells.${system}.default;
        };
      }
    );
}
