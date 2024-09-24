{
  description = "Vector_structure project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        cppProject = pkgs.clangStdenv.mkDerivation {
          name = "vector_structure";
          src = ./.;

          nativeBuildInputs = with pkgs; [ gnumake ];

          buildInputs = with pkgs; [ ];

          buildPhase = ''
            make -j $($NIX_BUILD_CORES)
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp build/vector_structure $out/bin/
          '';
        };

      in {
        packages = {
          vector_structure = cppProject;
          default = cppProject;
        };

        apps = {
          vector_structure = flake-utils.lib.mkApp { drv = cppProject; };
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
            echo "Build the project:  nix build .#vector_structure"
            echo "Run the project:    nix run   .#vector_structure"
            echo ""
            echo "Happy coding!"
          '';
        };
      }
    );
}
