{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    fish.enable = lib.mkEnableOption "Enable fish config";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;

      functions = {
        templator = ''
          set templates_path ~/templates
          while true
            set dirs (ls -d "$templates_path"/*)
            set -a dirs (echo exit)
            set templates_path (string replace -a " " \n $dirs | ${pkgs.fzf}/bin/fzf)

            if test $templates_path = (echo "exit")
              return
            end

            if test (ls $templates_path | ${pkgs.fzf}/bin/fzf -f "flake.nix")
              break
            end
          end

          cp -r "$templates_path"/. ./
        '';
      };
    };
  };
}
