# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "cotton";
    homeDirectory = "/home/cotton";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    userName = "cotton";
    userEmail = "cotton@trans.fish";
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
