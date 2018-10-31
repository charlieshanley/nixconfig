{ pkgs, ... }:

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
      };
      git = {
        enable = true;
        userName = "Charlie Hanley";
        userEmail = "charles.scott.hanley+git@gmail.com";
        aliases.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      vim = {
        enable = true;
        plugins = [ "gitgutter" "airline" "commentary" "gruvbox" "haskell-vim" ];
        extraConfig =
        ''
          set nocompatible
          filetype plugin indent on
          syntax on
          set hidden

          " better command-line completion
          set wildmenu

          " show partial commands in last line of screen
          set showcmd

          " search options
          set incsearch
          set ignorecase
          set smartcase

          " Allow backspacing over autoindent, line breaks and start of insert action
          set backspace=indent,eol,start

          " When opening a new line and no filetype-specific indenting is enabled, keep
          " the same indent as the line you're currently on. Useful for READMEs, etc.
          set autoindent

          " Revert to absolute numbers in insert mode and when buffer loses focus
          augroup numbertoggle
              autocmd!
              autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
              autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
          augroup end

          " Quickly time out on keycodes, but never time out on mappings
          set notimeout ttimeout ttimeoutlen=200

          " Always show at least one line above or below cursor.
          set scrolloff=3

          " Indentation settings for using 4 spaces instead of tabs.
          " Do not change 'tabstop' from its default value of 8 with this setup.
          set shiftwidth=4
          set softtabstop=4
          set expandtab

          set colorcolumn=80

          " gitgutter update interval
          set updatetime=300

          " Colorscheme
          set background=dark
          colorscheme gruvbox

          " Mappings
          let mapleader=" "

          " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
          map Y y$

          " Map <C-L> (redraw screen) to also turn off search highlighting until next search
          nnoremap <C-L> :nohl<CR><C-L>
        '';
      };
    };
  };
}
