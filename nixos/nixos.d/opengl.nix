{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      pkgsi686Linux.libva

      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      # intel-media-driver # only available starting nixos-19.03 or the current nixos-unstable
    ];
  };
}
