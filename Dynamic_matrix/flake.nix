{
  description = "Dynamic matrix project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        cppProject = pkgs.stdenv.mkDerivation {
          pname = "dynamic_matrix";
          version = "0.1.0";
          name = "dynamic_matrix-0.1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [ gnumake ];

          buildInputs = with pkgs; [ libcxx catch2 ];

          buildPhase = ''
            make -j $NIX_BUILD_CORES
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp build/dynamic_matrix $out/bin/
          '';
        };

      in {
        packages = {
          dynamic_matrix = cppProject;
          default = cppProject;
        };

        apps = {
          dynamic_matrix = flake-utils.lib.mkApp { drv = cppProject; };
          default = flake-utils.lib.mkApp { drv = cppProject; };
        };

        devShells.default = pkgs.mkShell {
          name = "dynamic_matrix-dev-shell";

          nativeBuildInputs = with pkgs; [ gnumake ccache git bear ];

          buildInputs = with pkgs; [ libcxx catch2 ];

          shellHook = ''
            export CC=gcc
            export CXX=g++
            export CXXFLAGS="''${CXXFLAGS:-}"

            export CCACHE_DIR=$HOME/.ccache
            export PATH="$HOME/.ccache/bin:$PATH"
            export CPATH=${pkgs.catch2}/include:$CPATH

            alias c=clear

            echo "======================================"
            echo "$(gcc    --version | head -n 1)"
            echo "$(make   --version | head -n 1)"
            echo ""
            echo "Build the project:  nix build .#dynamic_matrix"
            echo "Run the project:    nix run   .#dynamic_matrix"
            echo ""
            echo "Happy coding!"
          '';
        };
      });
}
