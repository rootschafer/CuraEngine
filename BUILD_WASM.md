# Building CuraEngine for WASM

This guide explains how to build CuraEngine to WebAssembly using the provided Nix development environment.

## Prerequisites
- Nix installed with Flakes enabled.

## Steps

1. **Enter the Development Shell**
   ```bash
   nix develop
   ```

2. **Configure Conan (First Time Only)**
   Detect your default profile (we will override it for Emscripten later, but this initializes Conan):
   ```bash
   conan profile detect --force
   ```
   
   *Note: We have modified `conanfile.py` to remove the dependency on the Ultimaker remote for `sentrylibrary`, so you do NOT need to add the remote.*

3. **Install Dependencies**
   Run the Conan install command specifying Emscripten as the target OS. 
   
   ```bash
   conan install . \
     --build=missing \
     -s os=Emscripten \
     -s arch=wasm \
     -s compiler=clang \
     -s compiler.version=19 \
     -s compiler.libcxx=libc++ \
     -o enable_arcus=False \
     -o enable_plugins=False
   ```
   *Note: Adjust `compiler.version` to match the emscripten clang version if needed (check with `emcc --version`).*

4. **Build**
   ```bash
   conan build .
   ```

5. **Output**
   The build artifacts (`CuraEngine.js` and `CuraEngine.wasm`) will be in the `build/Release` (or similar) directory.
