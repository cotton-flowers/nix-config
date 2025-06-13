{
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  users.users.cotton = {
    isNormalUser = true;
    description = "cotton";
    extraGroups = ["audio" "sound" "video" "networkmanager" "wheel"];
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
