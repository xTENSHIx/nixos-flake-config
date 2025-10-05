{ pkgs, lib, config, ... }:


{
  home.username = "l9barack";
  home.homeDirectory = "/home/l9barack";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  programs.starship.enable = true;

  programs.zellij.enable = true;

 # Add some aliases
  home.shellAliases = {
    ll = "lsd -l";
    la = "lsd -la";
    gs = "git status";
    v = "vim";
  };
  
#  programs.doom-emacs = {
 #   enable = true;
  #  doomDir = "${config.xdg.configHome}/doom";
    # Optional, but recommended: make sure the runtime write area is outside the store
   # doomLocalDir = "${config.xdg.dataHome}/doom";
  
    # If you also want this to provide `emacs` directly:
    #provideEmacs = true;
  #};

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "25.05";
}

