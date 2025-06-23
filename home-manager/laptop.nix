{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    foot
    ripgrep
    discord
    firefox
    wl-clipboard
    #	    spotify
    #	    zathura
    #	    ghc
    #	    obsidian
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  services.udiskie = {
    enable = true;
    settings.program_options.file_manager = "${pkgs.yazi}/bin/yazi";
  };
}
