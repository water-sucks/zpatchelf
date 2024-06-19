{
  stdenv,
  lib,
  zig,
  nix-gitignore,
}:
stdenv.mkDerivation {
  pname = "zpatchelf";
  version = "0.1.0";
  src = nix-gitignore.gitignoreSource [] ./.;

  nativeBuildInputs = [zig.hook];

  meta = with lib; {
    homepage = "https://github.com/water-sucks/nixos";
    description = "A clone of the patchelf utility from NixOS, in Zig";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [water-sucks];
  };
}
