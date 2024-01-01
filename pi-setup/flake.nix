{
  description = "Build image";
  outputs = { self, nixpkgs }: rec {
    nixosConfigurations.rpi = nixpkgs.lib.nixosSystem {
      modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        {
          nixpkgs.config.allowUnsupportedSystem = true;
          nixpkgs.hostPlatform.system = "aarch64-linux";
          nixpkgs.buildPlatform.system = "x86_64-linux";

          sdImage.compressImage = false;

          time.timeZone = "Europe/Berlin";
          i18n.defaultLocale = "en_US.UTF-8";

          users.users.pi = {
            isNormalUser = true;
            #initialHashedPassword= "";
            password = "";
            extraGroups = [
                "wheel" # Enable ‘sudo’ for the user.
            ];
            openssh.authorizedKeys.keys = [ "" ];
          };

          # Allow ssh in
          services.openssh.enable = true;

          networking = {
            hostName = "pi";
            interfaces.wlan0 = {
                useDHCP = true;
            };
            interfaces.eth0 = {
                useDHCP = true;
            };
            wireless.enable = true;
            wireless.interfaces = [ "wlan0" ];
            wireless.networks."Casa".psk = "04567987240964352128";
          };

          system = {
                stateVersion = "23.11";
            };
        }
      ];
    };
    images.rpi = nixosConfigurations.rpi.config.system.build.sdImage;
  };
}
