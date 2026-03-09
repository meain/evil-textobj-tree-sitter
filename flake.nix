{
  description = "evil-textobj-tree-sitter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # Wrapper that sets GIT_DIR/GIT_WORK_TREE for jj repos so
          # tree-sitter-langs can find the git repo during eask install-deps
          eask-jj = pkgs.writeShellScriptBin "eask" ''
            if [ -z "''${GIT_DIR:-}" ] && command -v jj >/dev/null 2>&1 && jj root >/dev/null 2>&1; then
              export GIT_DIR="$(jj root)/.jj/repo/store/git"
              export GIT_WORK_TREE="$(jj root)"
            fi
            exec ${pkgs.eask-cli}/bin/eask "$@"
          '';
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.emacs
              eask-jj
              pkgs.go
              pkgs.gcc
            ];
          };
        });
    };
}
