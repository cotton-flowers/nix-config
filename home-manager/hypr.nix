{pkgs, ... } : {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
	"$mod" = "SUPER";
	bind = [
	"$mod, q, exec, foot"	
	"$mod, f, exec, firefox"
	];
    };
  };
  
  programs.hyprlock = {
    enable = true;
    # fill out... reference mynixos.com.
  };

  programs.foot = { enable = true; };
}
