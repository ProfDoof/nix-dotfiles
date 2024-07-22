# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let 
  boi = uuid:
    { device = "/dev/disk/by-uuid/${uuid}";
      options = [ "nofail" ];
    };

  extraEnv = {WLR_NO_HARDWARE_CURSORS = "1"; };
in
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  fileSystems."/bois/bigboi" = ( boi "84499ee8-a964-4b66-a22d-d26364c41813" );
  fileSystems."/bois/fastboi" = ( boi "01d4ff88-0197-4aee-a754-300e363336c7" ); 
  fileSystems."/bois/smallboi" = ( boi "4590f3a6-d6b2-4941-960f-1a584140876c" );

  security.polkit.enable = true;
  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-validation-layers
    ];
  };

  environment.variables = extraEnv;
  environment.sessionVariables = extraEnv;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    forceFullCompositionPipeline = true;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.logind.lidSwitchExternalPower = "ignore";
  # systemd.tmpfiles.rules = 
  # let
  #   perms = "- gdm gdm -";
  #   mkTmpfileRules = name: contents:
  #     [ "f+ ${name} ${perms}"] ++ map (l: "w+ ${name} - - - - ${l}") (builtins.split "\n" contents);
  # in
  #   mkTmpfileRules "/run/gdm/.config/monitors.xml" 
  #     ''
  #       <monitors version="2">
  #         <configuration>
  #           <logicalmonitor>
  #             <x>0</x>
  #             <y>0</x>
  #             <scale>2</scale>
  #             <primary>yes</primary>
  #             <monitor>
  #               <monitorspec>
  #                 <connector>eDP-1</connector>
  #                 <vendor>unknown</vendor>
  #                 <product>unknown</product>
  #                 <serial>unknown</serial>
  #               </monitorspec>
  #               <mode>
  #                 <width>4112</width>
  #                 <height>2572</height>
  #                 <rate>60</rate>
  #               </mode>
  #             </monitor>
  #           </logicalmonitor>
  #         </configuration>
  #       </monitors>
  #     '';
  
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.light.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "buford"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    # displayManager.gdm.enable = lib.mkDefault true;
    videoDrivers = [ "nvidia" ];
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu";
        user = "john";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  system.nixos.tags = [ "sway" ];

  
  # specialisation = {
  #   gnome.configuration = {
  #     services.xserver.desktopManager.gnome.enable = true;
  #     system.nixos.tags = [ "gnome" ];
  #   };
  #   pantheon.configuration = {
  #     services.xserver = {
  #       desktopManager.pantheon.enable = true;
  #       displayManager = {
  #         gdm.enable = false;
  #         lightdm.enable = true;
  #       };
  #     };

  #     system.nixos.tags = [ "pantheon" ];
  #   };
  #   kde.configuration = {
  #     services = {
  #       xserver.displayManager.gdm.enable = false;
  #       desktopManager.plasma6.enable = true;
  #       displayManager.sddm = {
  #         enable = true;
  #         wayland.enable = true;
  #       };
  #     };
  #     system.nixos.tags = [ "plasma" ];
  #   };
  #   cosmic.configuration = {
  #     services = {
  #       xserver.displayManager.gdm.enable = false;
  #       desktopManager.cosmic.enable = true;
  #       displayManager.cosmic-greeter.enable = true;
  #     };
  #     system.nixos.tags = [ "cosmic" ];
  #   };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.john = {
    isNormalUser = true;
    description = "John Marsden";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    nerdfonts
    grim
    slurp
    wl-clipboard
    mako
    pavucontrol
    wireplumber
    discord
    sway-contrib.grimshot
    glxinfo
    vulkan-tools
    glmark2
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
