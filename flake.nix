{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: let

    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};

    buildInputs = with pkgs; [
      texliveFull
      gnumake
      zip
    ];

  in
  {
    packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {

      name = "cppdevcourse-documents";

      src = ./.;

      nativeBuildInputs = buildInputs;

      buildPhase = ''
        runHook preBuild
        make clean
        make -j"$NIX_BUILD_CORES"
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p "$out"
        make install PREFIX="$out"
        runHook postInstall
      '';

    };

    devShells.${system}.default = pkgs.mkShellNoCC {
      packages = buildInputs;
    };

    checks.${system}.fmt = pkgs.runCommand "check-fmt" { } ''
      ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt --check ${toString self}
      mkdir -p $out
    '';

  };
}