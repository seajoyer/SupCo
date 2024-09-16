{ pkgs ? import <nixpkgs> {} }:

let
  buildScript = pkgs.writeScriptBin "build" ''
    #!${pkgs.stdenv.shell}
    make -j$(( $(nproc) / 2 ))
  '';

  cleanScript = pkgs.writeScriptBin "clean" ''
    #!${pkgs.stdenv.shell}
    make clean
  '';

  runScript = pkgs.writeScriptBin "run" ''
    #!${pkgs.stdenv.shell}
    make run
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Compiler and build tools
    clang
    libcxx
    gnumake

    # Libraries
    eigen

    # Development tools
    clang-tools
    bear

    # misc
    git-filter-repo
    git

    # Custom build and run scripts
    buildScript
    cleanScript
    runScript

    (python3.withPackages (ps:
      with ps; [
        numpy
        pandas
        pyright
        matplotlib
        jupyter
        pytest
        nose
        pyflakes
      ]))
  ];

  shellHook = ''
    alias c=clear

    export CC=${pkgs.clang}/bin/clang
    export CXX=${pkgs.clang}/bin/clang++
    export CXXFLAGS="-I${pkgs.eigen}/include/eigen3 ${CXXFLAGS:-}"
    export CMAKE_PREFIX_PATH="${pkgs.eigen}/include/eigen3:$CMAKE_PREFIX_PATH"

    if [ ! -f compile_commands.json ]; then
      bear -- make -B  # Use -B to force make to run and generate compile commands
    fi

    echo "C++ Development Environment"
    echo "=========================="
    echo "Build your project with: build"
    echo "Clean your project with: clean"
    echo "Run your project with:   run"
    echo ""
    echo "Happy coding!"
  '';
}
