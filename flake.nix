{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      python3 = (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.diagrams
      ]));
      diag = pkgs.writeShellApplication {
        name = "watch-diagram";
        text = ''
        #!/bin/sh
        ${pkgs.python3Packages.pywatchman}/bin/watchman-wait --max-events 0 -p "$1" -- . | while read -r line; do  ${python3}/bin/python "$line" ;  clear; ${pkgs.viu}/bin/viu "$line.diag.png" ; done  
        '';
        runtimeInputs = with pkgs; [
          viu
          watchman
          python3Packages.pywatchman
        ];
      };
          
    in
    {
      packages = {
        diag = diag;
      };
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          diag
          python3
          viu
        ];
      };
    }
  );
}
