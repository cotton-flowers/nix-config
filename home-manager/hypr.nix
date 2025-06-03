{pkgs, ... } : {
  wayland.windowManager.hyprland = {
    enable = true;
    "$mod" = "SUPER";
    bind = [
	"$mod, Q, exec, foot"	
    ];
  };
  
  programs.hyprlock = {
    enable = true;
    # fill out... reference mynixos.com.
  }

#  waybar.enable = true;
#  wofy.enable = true;
}
