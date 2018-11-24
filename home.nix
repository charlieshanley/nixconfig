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
      latitude  =  "38.9072";
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
        extraConfig = ''
          # remap prefix from `Ctrl-B` to `Ctrl-Space`
          unbind C-b
          set-option -g prefix C-Space
          bind-key C-Space send-prefix

          # split panes using \ and -
          bind \ split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          unbind '"'
          unbind %

          # Vim-style pane selection
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Use Alt-vim keys without prefix to switch panes
          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          # Vim-style pane resizing
          bind -r C-h resize-pane -L
          bind -r C-j resize-pane -D
          bind -r C-k resize-pane -U
          bind -r C-l resize-pane -R

          # No delay for escape key press
          set -sg escape-time 0

          # Set the base index for windows and panes to 1 rather than 0
          set -g base-index 1
          set -g pane-base-index 1

          # Theme
          set -g status-bg black
          set -g status-fg white
          set -g window-status-current-bg white
          set -g window-status-current-fg black
          set -g window-status-current-attr bold

          # distinguish active pane from inactive panes
          set -g pane-border-style 'fg=colour238,bg=colour235'
          set -g pane-active-border-style 'fg=colour51,bg=colour236'

          set -g status-interval 60
          set -g status-left-length 30
          set -g status-left '#[fg=grey](#S)'
          set -g status-justify centre

          # notify of activity in other windows
          setw -g monitor-activity on
          set -g visual-activity on
        '';
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
