{ pkgs, ... }:

let
  gruvbox-phaazon = pkgs.callPackage ./gruvbox-phaazon.nix {};
  haskell-vim-csh = pkgs.callPackage ./haskell-vim-csh.nix {};
in

{
  imports =
    [
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.charlie = {
    isNormalUser = true;
    home = "/home/charlie";
    description = "Charlie Hanley";
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
    uid = 1000;
  };

  home-manager.users.charlie = {

    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = pkgs.callPackage ./write-xmonad.hs {
        xmobar   = pkgs.haskellPackages.xmobar;
        xmobarrc = ./xmobarrc;
        bg-img   = ./bg.png;
      };
    };

    programs = {
      urxvt = {
        enable = true;
        scroll.bar.enable = false;
        transparent = true;
        fonts = [ "xft:DejaVu Sans Mono:size=9" ];
        extraConfig = {
          shading = 20;
          foreground     = "#ebdbb2";
          highlightColor = "#7c6f64";
          cursorColor    = "#7c6f64";
          visualBell     = true;
        };
        keybindings = {
        };
      };

      bash = {
        enable = true;
        initExtra = ''
        source ${gruvbox-phaazon}/share/vim-plugins/gruvbox/gruvbox_256palette.sh
        export LESS_TERMCAP_so=$'\E[30;43m'
        export LESS_TERMCAP_se=$'\E[39;49m'
        cs() { cd "$@" && ls -lat; }
        eval `dircolors ${./ls_colors}`
        '';
      };

      feh.enable = true;

      git = {
        enable = true;
        userName = "Charlie Hanley";
        userEmail = "charles.scott.hanley+git@gmail.com";
        aliases.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      tmux = {
        enable = true;
        extraConfig = builtins.readFile ./tmux.conf;
      };

      neovim = {
        enable = true;
        vimAlias = true;
        configure = {
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              gruvbox-phaazon
              gitgutter airline commentary nerdtree surround "fzf.vim"
              vim-nix haskell-vim-csh
            ];
            opt = [];
          };
          customRC = builtins.readFile ./vimrc;
        };
      };
    };

    services.redshift = {
      enable = true;
      latitude  =  "38.9072";
      longitude = "-77.0369";
      temperature = {
        day   = 6000;
        night = 2500;
      };
    };

    home.packages = with pkgs; [
      git
      ghc haskellPackages.ghcid cabal-install cabal2nix
      xosd # unstated dependency of osdCat function in XMonad
      keepass
    ];
  };
}
