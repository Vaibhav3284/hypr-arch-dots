
{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];
    
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      bored = import /home/bored/flakes/home-manager/home.nix;
      };
     };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bored = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
  

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  programs.partition-manager.enable = true;

  fonts.packages = with pkgs; [
  font-awesome
  jetbrains-mono
  notonoto
 
 ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   pkgs.kitty
   kitty
   alacritty
   fzf
   st
   xfce.thunar
   git
   gnumake
   wine
   waybar 
   pkgs.eww
   rofi-wayland
   dunst
   libnotify
   swww
   grim
   wl-clipboard
   slurp
   floorp
   steam
   discord
   flatpak
   home-manager
   sddm
   libsForQt5.qt5.qtquickcontrols2
   libsForQt5.qt5.qtgraphicaleffects
   file-roller
   nemo
   nemo-fileroller
   xfce.thunar-volman
   xfce.thunar-archive-plugin
   lxappearance
   gvfs
   fish
   tofi
   wlsunset 
   swaylock
   pavucontrol
   mangohud
   pkgs.ags
   swaybg
  ];
    system.stateVersion = "24.11"; # Did you read the comment?

}

