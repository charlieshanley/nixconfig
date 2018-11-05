{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "haskell-vim-csh";
  src = fetchFromGitHub {
    owner  = "charlieshanley";
    repo   = "haskell-vim";
    rev    = "1159923";
    sha256 = "0hyqfn865c1f12r5f61aijh05xd7kqvvppf9f6q2wivrzpn9n1yh";
  };
  installPhase = ''
    mkdir -p $out/share/vim-plugins/haskell-vim
    cp -r * $out/share/vim-plugins/haskell-vim/
  '';
}
