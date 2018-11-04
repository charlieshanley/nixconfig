{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "gruvbox-phaazon";
  src = fetchFromGitHub {
    owner  = "phaazon";
    repo   = "gruvbox";
    rev    = "189c1ff";
    sha256 = "0bcd4myj9k4548q2askpsw9gmiixpsxxip8lzgc10jw2fb62hh97";
  };
  installPhase = ''
    mkdir -p $out/share/vim-plugins/gruvbox
    cp -r * $out/share/vim-plugins/gruvbox/
  '';
}
