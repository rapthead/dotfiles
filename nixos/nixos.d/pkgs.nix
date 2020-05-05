{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # core
    ack
    at
    bash
    bc
    binutils
    curl
    dialog
    dnsutils
    dosfstools
    f2fs-tools
    fdupes
    file
    fzf
    git
    hddtemp
    hdparm
    htop
    iotop
    killall
    lm_sensors
    lsof
    mc
    nix-index
    renameutils
    rsync
    rxvt_unicode
    screen
    sshfs
    stress
    telnet
    traceroute
    tty-clock
    unrar
    unzip
    vifm
    vim
    wget
    whois
    zip
    zsh

    # games
    wine
    steam-run-native
    steam

    # work
    (yarn.override { nodejs = nodejs-slim-12_x; })
    awscli
    diesel-cli
    gcc
    gitg
    graphviz
    imagemagick
    jq
    neovim-remote
    nodejs-slim-12_x
    rustup
    umlet
    openssl

    # multimedia

    # desktop
    scrot
    feh
    chromium
    evince
    fbreader
    gimp
    rofi
    shutter
    tdesktop
    transmission-gtk
    vivaldi

    glxinfo
    xorg.xev
    xorg.xbacklight
    xclip
    xsel
    xorg.xkill

    # multimedia
    ffmpeg
    flac
    libva-utils
    mediainfo
    mkvtoolnix
    mpc_cli
    mpv
    ncmpcpp
    python3
    youtube-dl
  ];
}
