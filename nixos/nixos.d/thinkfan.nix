{ config, lib, pkgs, ... }:

{
  services.thinkfan = {
    enable = true;
    sensors = ''
      hwmon /sys/devices/virtual/thermal/thermal_zone0/temp
      hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input
    '';
    levels = ''
          (0,     0,      60)
          (1,     55,     61)
          (2,     56,     62)
          (3,     57,     63)
          (6,     58,     64)
          (7,     60,     85)
          (127,   80,     32767)
    '';
  };
}
