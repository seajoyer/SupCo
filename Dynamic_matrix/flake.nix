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

        cppProject = pkgs.clangStdenv.mkDerivation {
          name = "dynamic_matrix";
          src = ./.;

          nativeBuildInputs = with pkgs; [ gnumake libcc ];

          buildInputs = with pkgs; [ ];

          buildPhase = ''
            make -j $($NIX_BUILD_CORES)
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
          nativeBuildInputs = with pkgs; [ ccache gnumake git git-filter-repo bear ];

          buildInputs = with pkgs; [ clang libcxx ];

          shellHook = ''
            export CC=clang
            export CXX=clang++
            export CXXFLAGS="''${CXXFLAGS:-}"

            export CCACHE_DIR=$HOME/.ccache
            export PATH="$HOME/.ccache/bin:$PATH"

            alias c=clear

            echo "C++ Development Environment"
            echo "======================================"
            echo "$(clang --version | head -n 1)"
            echo "$(make --version | head -n 1)"
            echo ""
            echo "Build the project:  nix build .#dynamic_matrix"
            echo "Run the project:    nix run   .#dynamic_matrix"
            echo ""
            echo "Happy coding!"
          '';
        };
      }
    );
}
