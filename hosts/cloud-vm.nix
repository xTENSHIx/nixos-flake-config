{ config, pkgs, lib, ... }: 

{

  imports = [ ./hardware-configuration.nix ];
   
   nixpkgs = {
     inherit pkgs;
   };

   nix.package = pkgs.nixVersions.stable;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   boot.kernelPackages = pkgs.linuxPackages_6_6;

 
  users.users.l9barack =
    { isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [

    ];
  };


  security.sudo.wheelNeedsPassword = false;

  services.openssh.settings.PermitRootLogin = "prohibit-password";

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [ (nerd-fonts.jetbrains-mono) (nerd-fonts.fira-code)];

  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    git
    zellij
    vim
    curl
    wget
    bat
    fd
    ripgrep
    fzf
    lsd
    tldr
    dust
    zoxide
    jdk
  ];

  
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "nix-code-server";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
 
   ];

  system.stateVersion = "25.05";
}
