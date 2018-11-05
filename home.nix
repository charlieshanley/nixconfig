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

    services.redshift = {
      enable = true;
      latitude  = "38.9072";
      longitude = "-77.0369";
      temperature = {
        day   = 6000;
        night = 2500;
      };
    };

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
        source ${gruvbox-phaazon}/share/vim-plugins/gruvbox/gruvbox_256palette.sh
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
        vimAlias = true;
        configure = {
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              gruvbox-phaazon
              gitgutter airline commentary
              vim-nix haskell-vim-csh
            ];
            opt = [];
          };
          customRC = ''
	    set nocompatible
	    syntax on
	    filetype plugin indent on
	    set hidden

            " for gitgutter
	    set updatetime=300 

            let g:gruvbox_italic=1
	    colorscheme gruvbox
	    set background=dark
            highlight Normal ctermbg=None

	    set wildmenu
            set showcmd
	    set hlsearch
	    set incsearch
	    set ignorecase
	    set smartcase
	    set backspace=indent,eol,start
	    set autoindent
	    set nostartofline
	    set ruler
	    set laststatus=2
	    set confirm

	    set number relativenumber

	    " revert to absolute numbers in insert mode and when buffer loses focus
	    augroup numbertoggle
	      autocmd!
	      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
	    augroup end

	    set notimeout ttimeout ttimeoutlen=200

	    " <F11> to toggle between paste and nopaste
	    set pastetoggle=<F11>
	    set scrolloff=3
	    set shiftwidth=4
	    set softtabstop=4
	    set expandtab
	    set colorcolumn=80

	    let mapleader=" "
	    map Y y$
	    noremap <C-L> :nohl<CR><C-L>
          '';
        };
      };
    };
  };
}
