{
  description = "NixOS + Home Manager setup for cloud dev workstation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    #emacs-overlay.url = "github:nix-community/emacs-overlay";    
    # Add Doom Unstraightened
  #  doom-unstr = {
   #   url = "github:marienz/nix-doom-emacs-unstraightened";
    #  inputs.nixpkgs.follows = "nixpkgs";
     # inputs.emacs-overlay.follows = "emacs-overlay";
   # };
  };
  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    nixosConfigurations."cloud-vm" = lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/cloud-vm.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.l9barack = {
            imports = [
            #  inputs.doom-unstr.hmModule
              ./home/l9barack.nix
            ];
          };
        }
      ];

      # Ensure pkgs consistency through specialArgs, not via nixpkgs arg
      specialArgs = {
        inherit pkgs;
      };
    };
  };
}

