{
  pkgs,
  config,
  ...
}: {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [dmenu i3statis i3lock];
    };
  };
}
