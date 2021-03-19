let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  build = import ./build.nix { inherit sources pkgs; };

  compile =
    pkgs.writeShellScriptBin "compile"
      ''
        rm -rf lua
        cp --no-preserve=mode -r -T ${build} .
      '';

in
pkgs.mkShell {
  buildInputs = [
    compile
  ];
}
