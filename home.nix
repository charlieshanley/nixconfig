{ pkgs, ... }:

let
  gruvbox-phaazon = pkgs.callPackage ./gruvbox-phaazon.nix {};
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
    # xsession.windowManager.xmonad.config = pkgs.writeText "xmonad.hs" ''
    # '';
    programs = {
      urxvt = {
        enable = true;
        scroll.bar.enable = false;
        transparent = true;
        fonts = [ "xft:DejaVu Sans Mono:size=9" ];
        extraConfig = {
          foreground = "#ebdbb2";
        };
        keybindings = {
        };
      };
      bash = {
        enable = true;
        initExtra = ''
        cs() { cd "$@" && ls -lat; }
        '';
      };
      git = {
        enable = true;
        userName = "Charlie Hanley";
        userEmail = "charles.scott.hanley+git@gmail.com";
        aliases.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      neovim = {
        enable = true;
        configure = {
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [ ];
            opt = [ haskell-vim ];
          };
	  customRC = ''
	    set nocompatible
	    filetype plugin indent on
	    syntax on
	    packadd haskell-vim
	  '';
        };
      };
      vim = {
        enable = true; 
	plugins = [ "haskell-vim" ];
	extraConfig = ''
          set nocompatible
	  filetype plugin indent on
	  syntax on
	'';
      };
    };
  };
}
