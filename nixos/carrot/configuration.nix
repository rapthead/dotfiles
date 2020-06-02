# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let unstable = import <nixos-unstable> {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nixos.d/boot.efi.nix
      ./nixos.d/pkgs.nix
      ./nixos.d/xserver+wm.nix
      ./nixos.d/opengl.nix
      ./nixos.d/thinkfan.nix
    ];

  networking.hostName = "carrot"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noname = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "vboxusers" ]; # Enable ‘sudo’ for the user.
  };

  services = {
    redis = {
      enable = true;
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
      ensureDatabases = [ "musiclib" "ppldo" "ppldo_dev"  "ppldo_testing" ];
      ensureUsers = 	[
        {
          name = "noname";
        }
      ];
      # initialScript = pkgs.writeText "backend-initScript" ''
      #   ALTER USER noname WITH SUPERUSER;
      # ''; # dont work
      identMap = ''
        noname-user noname noname
      '';
    };
  };

  systemd.services.disable-cdrom-eject = {
    script = "/run/current-system/sw/bin/eject --manualeject on /dev/sr0";
    wantedBy = [ "multi-user.target" ];
  };
  powerManagement.resumeCommands = "/run/current-system/sw/bin/eject --manualeject on /dev/sr0";
  services.udev.extraRules = ''
    ENV{DISK_EJECT_REQUEST}=="?*", RUN="", GOTO="cdrom_end"
  '';
  services.teamviewer.enable = true;

  environment.systemPackages = with pkgs; [
    baobab
    electron

    tor-browser-bundle-bin
    vim
    skypeforlinux
    woeusb

    gnumake
    autoconf
    automake

    # solaar
    thunderbird
    tree
    go
    unstable.neovim
    unstable.neovim-qt

    docker-compose
    wrk

    easytag
    nmap
    xkb-switch

    protobuf
    go-protobuf

    entr
    fswatch
    inotify-tools
    firefox

    ansible
    sshpass
  ];

  virtualisation.docker.enable = true;
  programs.fuse.userAllowOther = true;

  virtualisation.virtualbox.host.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
