{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    lf.enable = lib.mkEnableOption "Enable lf";
  };

  config = lib.mkIf config.lf.enable {
    xdg.configFile."lf/icons".source = ./config/icons;
    programs.lf = {
      enable = true;

      commands = {
        editor-open = ''$$EDITOR $f'';
        terminal-open = ''
          ''${{
              nohup ${inputs.wezterm.packages.${pkgs.system}.default}/bin/wezterm start --new-tab --cwd $(dirname $f) | rm nohup.out &
            }}
        '';

        mkdir = ''
          ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
        mkfile = ''
          ''${{
            printf "File Name: "
            read FILE
            touch $FILE
          }}
        '';

        extract = ''
          ''${{
            case "$f" in
              *.zip) ${pkgs.unzip}/bin/unzip "$f" ;;
              *.taz.gz) tar -xzvf "$f" ;;
              *.tar.bz2) tar -xjvf "$f" ;;
              *.tar) tar -xvf "$f" ;;
              *) echo "Unsupported format" ;;
            esac
          }}
        '';
      };

      keybindings = {
        m = "";

        e = "editor-open";
        x = "terminal-open";

        mf = "mkfile";
        md = "mkdir";

        au = "extract";

        gd = "cd ~/Downloads";
        gc = "cd ~/nixos";
        gs = "cd ~/ssd/shizu";

        "." = "set hidden!";
      };

      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      extraConfig = let
        previewer = pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
    };
  };
}
