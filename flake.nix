{
  description = "A clone of the patchelf utility from NixOS, in Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          name = "zpatchelf-shell";
          packages = with pkgs; [zig];
        };

        packages.default = pkgs.callPackage (import ./package.nix) {};
      };
    };
}
