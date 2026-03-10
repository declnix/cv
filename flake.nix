{
  description = "JSON Resume";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    handlebars = pkgs.fetchurl {
      url = "https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.8/handlebars.min.js";
      hash = "sha256-DlQW8UXnvxbFhQQ1bHMv5+mWcfRpYZTFsUCiUtsC8K8=";
    };
  in {
    packages.${system}.default =
      pkgs.runCommand "resume" { buildInputs = [ pkgs.nodejs ]; } ''
        # Copy theme directory
        cp -r ${./theme} theme
        chmod -R u+w theme

        # Copy Handlebars to theme directory
        cp ${handlebars} theme/handlebars.min.js

        # Render resume
        node -e "
          const theme = require('./theme/render.js');
          const fs = require('fs');
          const data = JSON.parse(fs.readFileSync('${./resume.json}', 'utf-8'));
          const html = theme.render(data);
          fs.writeFileSync('index.html', html);
        "

        mkdir -p $out
        cp index.html $out/
        cp ${./me.jpg} $out/me.jpg
      '';
  };
}