{ config, pkgs, lib, ... }: 

{

  imports = [ ./hardware-configuration.nix ];
   
   nixpkgs = {
     inherit pkgs;
   };

   nix.package = pkgs.nixVersions.stable;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Create a personal user account
  users.users.l9barack =
    { isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo access
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4dAlAT5/Lk5KcCicLwzxvHpAgNZuTG6LJxJ7nAbLZy my-pc-key"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbtKZkhlPRD0sWhb4nfQJNwErPjQW2RCffdeKipb+UU ShellFish@iPad-24092025"
    ];
  };


  security.sudo.wheelNeedsPassword = false;

  # Disable root login with password for better security
  services.openssh.settings.PermitRootLogin = "prohibit-password";

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [ (nerd-fonts.jetbrains-mono) (nerd-fonts.fira-code)];

  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    git
    zellij
    vim
    
    #CLI Tools
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

    # Language Toolchains
    jdk
  ];

  
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "nix-code-server";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
     ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4dAlAT5/Lk5KcCicLwzxvHpAgNZuTG6LJxJ7nAbLZy''
     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbtKZkhlPRD0sWhb4nfQJNwErPjQW2RCffdeKipb+UU ShellFish@iPad-24092025" 
   ];

  system.stateVersion = "25.05";
}
