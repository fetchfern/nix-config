{ stdenv, ... }: let
  program = ''
    test -z \$TMUX && 1>&2 echo "Not in tmux" && exit
    tmux rename-window 'run'
    tmux new-window -n 'dev'
    tmux split-window -h 'bacon clippy || read -P ""'
  '';
in stdenv.mkDerivation {
  pname = "tmux-dev";
  version = "0.1.0";
  src = ./.;

  buildPhase = ''
    cat << EOF > tmux-dev
    ${program}
    EOF
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp tmux-dev $out/bin/tmux-dev
    chmod +x $out/bin/tmux-dev
  '';
}
