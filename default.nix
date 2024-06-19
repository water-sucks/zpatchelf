{
  stdenv,
  zig,
}: {
  name,
  src,
  packageRoot ? "./",
  depsHash,
} @ args:
stdenv.mkDerivation {
  name = "${name}-deps";

  nativeBuildInputs = [zig];

  inherit src;

  configurePhase =
    args.modConfigurePhase
    or ''
      runHook preConfigure
      cd "${packageRoot}"
      runHook postConfigure
    '';

  buildPhase = ''
    runHook preBuild
    zig build --fetch --global-cache-dir ".cache" --cache-dir "./zig-cache"
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    cp -r --reflink=auto zig-cache/p $out
    runHook postInstall
  '';

  dontFixup = true;
  dontPatchShebangs = true;

  outputHashMode = "recursive";
  outputHash = depsHash;
}
