{
  config,
  pkgs,
  user,
  ...
}:
{
  imports = [ ../base ];

  users.users."${user.username}" = {
    description = user.name;
    home = "/Users/${user.username}";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # subpixel font smoothing on non-apple LCDs
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;

  # dark mode
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  # enable full keyboard control
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;

  # disable press and hold to get keyrepeat
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;

  # always show scrollbars
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";

  # don't mess with my input
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # disable automatic termination of unused apps
  system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = true;

  # I don't use iCloud
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

  # expanded save panel
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  # set sidebar size to medium
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;

  system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = true;

  # disable animated focus ring
  system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = false;

  system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;

  # faster resize animations
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 5.0e-2;

  # expand printer dialog
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  # enable tap to click
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

  # enable two finger right click
  system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;

  # disable corner right click
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = null;
  # disable trackpad tap clicking
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadRightClick = true;

  # use proper scroll direction
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  # disable beep volume
  system.defaults.NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;

  # beep sound when changing volume
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 1;

  # system.defaults.universalaccess.reduceTransparency = true;
  # system.defaults.universalaccess.closeViewScrollWheelToggle = true;
  # system.defaults.universalaccess.closeViewZoomFollowsFocus = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.24;
  system.defaults.dock.orientation = "bottom";
  # only show open applications in the dock
  system.defaults.dock.static-only = true;
  system.defaults.dock.tilesize = 48; # default is 64

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.stateVersion = 4;
}
