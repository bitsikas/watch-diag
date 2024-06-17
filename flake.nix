{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      # watchman command that watches a list of files and executes a command on them when they change
      diag = pkgs.writeShellScriptBin "watch-diagram" ''
        #!/bin/sh
        ${pkgs.python3Packages.pywatchman}/bin/watchman-wait --max-events 0 -p "$1" -- . | while read line; do  ${pkgs.python3}/bin/python $line ;  clear; ${pkgs.viu}/bin/viu $line.diag.png ; done  
        '';
          
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          diag
        ];
      };
    }
  );
}
