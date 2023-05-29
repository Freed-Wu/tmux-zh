{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.python-setuptools-generate.url = "github:Freed-Wu/setuptools-generate";
  outputs = { self, nixpkgs, flake-utils, python-setuptools-generate }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let setuptools-generate = python-setuptools-generate.packages.${system}.default; in
        with nixpkgs.legacyPackages.${system};
        {
          formatter = nixpkgs-fmt;
          packages.default = stdenv.mkDerivation rec {
            pname = "tmux-zh";
            version = "";
            src = self;
            postPatch = ''
              substituteInPlace CMakeLists.txt \
              --replace ' /usr/' " $out/"
            '';
            nativeBuildInputs = [
              cmake
              gettext
              po4a
              opencc
              groff
            ];
          };
        }
      );
}
