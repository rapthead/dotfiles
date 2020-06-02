{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        (dunst.override { 
          dunstify = true;
        })
        (polybar.override { 
          i3Support = true;
          mpdSupport = true;
        })

        hicolor_icon_theme
        vanilla-dmz
        papirus-icon-theme
      ];
    };

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };
    synaptics = {
      enable = true;
      twoFingerScroll = true;
    };
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:caps_toggle";

    # Enable touchpad support.
    # libinput.enable = true;
  };

  services.urxvtd = {
    enable = true;
    package = pkgs.rxvt_unicode;
  };

  fonts.fonts = with pkgs; [
    # nerdfonts
    siji # polybar font
    source-code-pro
  ];
}
