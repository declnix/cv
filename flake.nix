{
  description = "CV builder environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.pandoc
          pkgs.makeWrapper # optional, in case you want scripts
        ];

        shellHook = ''
          echo "Pandoc available: $(pandoc --version | head -1)"
          echo "Run: pandoc cv.md -s -c style.css -o index.html"
        '';
      };
    };
}
