{
  description = "CuraEngine WASM Build Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            conan
            emscripten
            cmake
            ninja
            git
            python3
            nodejs # For running WASM tests if needed
          ];

          shellHook = ''
            echo "========================================"
            echo "CuraEngine WASM Build Environment"
            echo "========================================"
            echo "Tools available: conan, emcc, cmake, ninja"
            echo ""
            echo "To build CuraEngine for WASM:"
            echo "1. Configure Conan profile for Emscripten (one-time):"
            echo "   conan profile detect --force"
            echo ""
            echo "2. Install dependencies and build:"
            echo "   conan install . --build=missing -s os=Emscripten -s arch=wasm -s compiler=clang -s compiler.version=19 -s compiler.libcxx=libc++"
            echo "   conan build ."
            echo ""
            echo "Note: You may need to add the Ultimaker Conan remote if packages are missing:"
            echo "conan remote add ultimaker https://conan.cura.ultimaker.com/artifactory/api/conan/conan-central"
            echo "========================================"
          '';
        };
      }
    );
}
