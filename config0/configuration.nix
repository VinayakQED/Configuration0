# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    # <nixos-hardware/lenovo/thinkpad/p52>
 
    # "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/p52"

    # ./nvidia.nix
 ];

/*nix = {
    settings.substituters = [
      "https://cache.nixos.org/"#,
      "https://mirror.iitd.ac.in/nixos/"
      # ... other settings ...
    ];
    # ... other nix settings like trusted-users, etc. ...
  };
*/


nix.settings = {
  substituters = [
    "https://cache.nixos.org/"
    "https://nvidia.cachix.org"
  ];
  trusted-public-keys = [
    "nvidia.cachix.org-1:6xDLHYsKkT+lpPwhQo7Ah0k0rYFV7n4Rt/gZ+a5tz1I="
  ];
};

  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
  #boot.kernelPackages = pkgs.linuxPackages_latest;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ThinkPad_P52_NixOS"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
  networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

# Enable the X11 windowing system.
# You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

/*
services = {

  desktopManager.plasma6.enable = true;

  displayManager.sddm.enable = true;

  displayManager.sddm.wayland.enable = true;
};
*/

    #services.displayManager.defaultSession = "plasma";


# Enable the KDE Plasma Desktop Environment

    #services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

# Enable hyprland tiling window manager
    programs.hyprland.enable = true;

# SDDM for Hyprland and Plasma 6

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.General.DisplayServer = "wayland";
  };
    
    services.displayManager.defaultSession = "hyprland";

    services.hypridle.enable = true;

/*
# Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # For X11 app compatibility
    withUWSM = true; # Systemd integration
  };

# SDDM for Hyprland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.General.DisplayServer = "wayland";
  };
  services.displayManager.defaultSession = "hyprland-uwsm";
*/

# Enable Cinnamon Desktop Environment.
    #services.xserver.desktopManager.cinnamon.enable = true;

# Enable LXQT Desktop Environment
    #services.xserver.displayManager.lightdm.enable = true;
    #services.xserver.desktopManager.lxqt.enable = true;

    #services.displayManager.lightdm.enable = true;
    #services.desktopManager.lxqt.enable = true;

# Configure keymap in X11
# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Disable PulseAudio
    services.pulseaudio.enable = false;

# Enable sound with pipewire.

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = false;
};
    security.rtkit.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vinayak = {
    isNormalUser = true;
    description = "vinayak";
    extraGroups = [ "networkmanager" "wheel" "camera" "libvirtd" ];
    shell = pkgs.bash;
    packages = with pkgs; [
    #ollama-cuda
    #ungoogled-chromium
    ];
  };

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
    
    elisa
    korganizer
    #plasma-browser-integration # Comment out this line if you use KDE Connect
    #kdepim-runtime # Unneeded if you use Thunderbird, etc.
    konsole # Comment out this line if you use KDE's default terminal app
    #oxygen
    #kwrite
    kmail
    kwalletmanager
    plasma-systemmonitor
];

# $ nix search wget
    environment.systemPackages = with pkgs; [

/*
    lxqt.lxqt-wayland-session
    lxqt.lxqt-config
    lxqt.lxqt-panel
*/

 # KDE
    #kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    #kdePackages.kcalc # Calculator
    #kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    #kdePackages.kcolorchooser # A small utility to select a color
    #kdePackages.kolourpaint # Easy-to-use paint program
    #kdePackages.ksystemlog # KDE SystemLog Application
    #kdePackages.sddm-kcm # Configuration module for SDDM
    #kdiff3 # Compares and merges 2 or 3 files or directories
    #hardinfo2 # System information and benchmarks for Linux systems
    #haruna # Open source video player built with Qt/QML and libmpv
    #xclip # Tool to access the X clipboard from a console application

    #linuxKernel.kernels.linux_6_14
    #linuxKernel.kernels.linux_latest_libre

# CLI
 
# EDITOR
	vim
	neovim

# Terminal
	kitty
    #gnome-terminal

# Multiplex
	tmux

# System Monitor
	htop
	btop
	stacer
    fastfetch
    
# Network traffic monitor (used as an option)
    #vnstat
    #iftop
    nload # Not declared in option


	wget
	git
	fzf
	axel
	
    tealdeer
	bat
	entr
	eza
	lshw
	ncdu
	iw
    lf
	fwupd
	fwupd-efi	

	veracrypt
    cryptomator

    baobab
    #qdirstat
    #libsForQt5.filelight
    #kdePackages.filelight
	bleachbit
	gparted
	timeshift
	restic
	#restique
    #urbackup-client

	tlp
    auto-cpufreq
	tpacpi-bat

# Remote
	openssh
    kdePackages.kdeconnect-kde
	#libsForQt5.kdeconnect-kde

    rustdesk
    rustdesk-server

# Shell
    bash
    #bashInteractive
    #bashInteractiveFHS
    fish
    zsh
    #oh-my-zsh
    #zsh-autosuggestions

# Proton
	proton-pass
    protonvpn-gui

# Media
	vlc

# office & notes
	libreoffice-qt6-fresh

	calibre
	calibre-web

	#notepadqq
	notesnook
	#joplin

    #zotero
    #zk
    #mdzk

# Simple Gtk/Qt front-end to tesseract-ocr
    gImageReader
    tesseract

    poppler

# Download manager and torrent
    varia
	persepolis
    qbittorrent

# flatpak & Appimage
	flatpak
	#appimagekit

# Virtualization
	waydroid
	wl-clipboard
	bottles
	wine
	qemu
    qemu_kvm
	libvirt
    libvirt-glib # Libary for working with virtual machines
	virt-manager
    virtualbox
    #virtualboxKvm
	#vmware-workstation
    #ggnome-boxes
	docker
    #nvidia-docker
    podman

#Simple Wine and Proton-based compatibility tools manager
    #protonplus

#Install and manage Proton-GE and Luxtorpeda for Steam and Wine-GE for Lutris with this graphical user interface
    #proton-qt

#CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE
    #proton-ng

# Fonts
    #nerdfonts # removed temporarely
    #font-awesome

	#haskellPackages.utf
	#perl540Packages.PerlIOutf8_strict

# Utils
    xdg-utils
	pciutils
    bridge-utils
	usbutils
    coreutils-full
	#busybox
    outils
    wayland-utils
    vulkan-tools
	#toybox
	#cope

# Development
    python3Full
    python312Packages.pip
    python312Packages.ipython
    #python312Packages.ipython-genutils
    #python312Packages.ipyparallel
    #python312Packages.notedown
	gcc
	gdb
	clang

#Animation engine for explanatory math videos-Community version
    #manim

	#codeblocksFull
	#vscodium
	geany-with-vte
    #kdePackages.kate

# Android
    universal-android-debloater # uad-ng
    android-tools
	scrcpy
    #qtscrcpy

# Editing
	#libsForQt5.kdenlive
	kdePackages.kdenlive
	openshot-qt
	#flowblade
	#lightworks
    #davinci-resolve

	#gimp
	#gimp-with-plugins
    #inkscape
    inkscape-with-extensions
    imagemagick
    ffmpeg-full 

	blender
    obs-studio
    #audacity
    #ardour
    #vokoscreen

# CAD
    freecad
    librecad

# Nvidia
    #nvidia-settings
    #cudaPackages.cudatoolkit
    cudaPackages_12_4.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cudnn
    cudaPackages.libcublas
    #cudaPackages.cuda_nvc
    vdpauinfo
    libva-utils
	mesa-demos
	#driversi686Linux.mesa-demos
	#nvtopPackages.nvidia
	#nvidia-system-monitor-qt
    #nvidia-docker

	gpustat
	#python312Packages.gpustat
  (writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '')

# LLM
    ollama 

# Enable Tor
    #tor
    #torctl
    #torsocks
	tor-browser
    #arti
    #nyx
    #onioncircuits

# Enable I2P 	
	#i2p
	#i2pd

# Browser
	librewolf
    brave

# Hyprland

# Apps/utilities for the user
    hyprpaper
    hyprpicker
    hypridle
    hyprlock
    hyprsysteminfo
    hyprsunset
    hyprpolkitagent
    hyprland-qt-support
    #hyprqt6engine

# Libraries and other utilities
    hyprcursor
    hyprutils
    hyprlang
    hyprwayland-scanner
    aquamarine
    hyprgraphics
    hyprland-qtutils

	waybar
	rofi-wayland
    wofi
    #swaybg

	hyprshot
    flameshot
	swaynotificationcenter
    libnotify
    iio-hyprland
    networkmanagerapplet
    pavucontrol
    brightnessctl
    xdg-desktop-portal-hyprland


# Bluetooth
	#bluez
    blueman
    #blueberry
	kdePackages.bluedevil
    #bluetooh_battery

    #sbclPackages.qtcore
    #sbclPackages.drakma

# Camera
    gphoto2
    #webcamoid
    #cheese
    #snapshot
    #guvcview
    #
    #cameractrls
    #fswebcam
    #libwebcam

# Virtual keyboard
    #maliit-keyboard
    #squeekboard

# Calculator
   qalculate-gtk

   	#glmark2
    #ulauncher

    #
    #ventoy
    #signal-desktop
    #
    #
    #
    #
    #
    #cameractrls
    #fswebcam
    #libwebcam

# Virtual keyboard
    #maliit-keyboard
    #squeekboard

# Calculator
   qalculate-gtk

   	#glmark2
    #ulauncher

    #
    #ventoy
    #signal-desktop
    #
    #
    #
    #
    #
    #
  ];

# Enale Nix Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Automatic Garbage Collection
    nix.gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 3d";
        };

    nix.settings.auto-optimise-store = true;

# Auto system update
/*    system.autoUpgrade = {
      enable = true;
};*/

/*
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
*/

# Enable I2P networking  Commented out because not in use.
/*
    services.i2pd.enable = true;
    systemd.services.i2pd.wantedBy = lib.mkForce [];
    services.i2p.enable = true;
    systemd.services.i2p.wantedBy = lib.mkForce [];
*/

# Keep Tor installed but disable auto-start
    systemd.services.tor.wantedBy = lib.mkForce [];
    systemd.services.torctl.wantedBy = lib.mkForce [];

# Enable network usage statistics
    services.vnstat.enable = true;
    systemd.services.vnstat.wantedBy = lib.mkForce [];

    programs.iftop.enable = true;

# Enable Virtualisation

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["vinayak"];

    virtualisation.libvirtd.enable = true;
    systemd.services.libvirtd.wantedBy = lib.mkForce [];

    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd.qemu.ovmf.enable = true;

    virtualisation.virtualbox.host.enable = true;
    systemd.services.virtualbox.wantedBy = lib.mkForce [];
    #virtualisation.virtualbox.host.enableKvm = true;

	#virtualisation.vmware.host.enable = true;
    #virtualisation.vmware.guest.enable = true;

	virtualisation.waydroid.enable = true;
    systemd.services.waydroid.wantedBy = lib.mkForce [];

	virtualisation.podman.enable = true;
    systemd.services.podman.wantedBy = lib.mkForce [];
    #virtualisation.podman.enableNvidia = true;

    virtualisation.docker.enable = true;
    systemd.services.docker.wantedBy = lib.mkForce [];

# Nvidia (config build 02/07/25)
    services.xserver.videoDrivers = [ "nvidia" ];

# Test optimuze nvidia configuration
hardware.nvidia = {
  modesetting.enable = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  powerManagement.enable = true;
  powerManagement.finegrained = true;
  nvidiaSettings = true;
  open = false;
  prime = {
    offload.enable = true;
    sync.enable = false;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
};
boot.kernelParams = [
  "nvidia-drm.modeset=1"
  "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  "nvidia.NVreg_TemporaryFilePath=/var/tmp"
];


/*
hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];
};
*/

# Wayland-friendly OpenGL setup
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ ];
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50; # Limit CPU performance on battery
    };
  };
  services.auto-cpufreq.enable = true;

# Running AI with Ollama 
	services.ollama.enable = true;
    systemd.services.ollama.wantedBy = lib.mkForce [];
/*
    nixpkgs.config.cudaSupport = true;
    services.ollama.acceleration = "cuda";
*/

# Enable Flatpak
	services.flatpak.enable = true;

# Enable Appimages
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

	services.throttled.enable = lib.mkDefault true;

# OBS-studio Camera
    #programs.obs-studio.enableVirtualCamera = true;

# Enable KDE Connect
    programs.kdeconnect.enable = true;

   # programs.gsconnect.enable = true;

# Enable Kclock
    programs.kclock.enable = true;

# Enable Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

# Enable Camera and gphoto2
    programs.gphoto2.enable = true;
    #users.users.vinayak.extraGroups = ["camera"];

/* Shell Options */
    programs.zsh.enable = true;
    #programs.direnv.enableZshIntegration = true;
    #programs.zsh.syntaxHighlighting.enable = true;
    #programs.nix-index.enableZshIntegration = true;
    #programs.zsh.autosuggestions.enable = true;
    #programs.zsh.ohMyZsh.enable = true;
    #programs.zsh.zsh-autoenv.enable = true;
    #programs.zsh.enableCompletion = true;

    programs.fish.enable = true;
    #programs.nix-index.enableFishIntegration = true;
    #programs.direnv.enableFishIntegration = true;
    #programs.foot.enableFishIntegration = true;

    #programs.bash.enableCompletion.enable = true;
    #programs.bash.enableCompletion = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
