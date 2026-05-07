{ ... }:
let
  extensionIDs = [
    "78272b6fa58f4a1abaac99321d503a20@proton.me" # Proton Pass
    "{2e707e37-a18d-49c7-ab9b-7ea6c6318c44}" # Marginalia Search
    "{74145f27-f039-47ce-a470-a662b129930a}" # ClearURLs
    "addon@darkreader.org" # Dark Reader
    "uBlock0@raymondhill.net" # uBlock Origin
  ];
  extensionSettings = builtins.listToAttrs (
    map (id: {
      name = id;
      value = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
        installation_mode = "force_installed";
      };
    }) extensionIDs
  );
in
{
  flake.nixosModules.firefox = {
    # From https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    # For extension IDs go to about:support in Firefox
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "en-GB"
      ];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisplayBookmarksToolbar = "newtab";
        DisplayMenuBar = "never";
        ExtensionSettings = extensionSettings;
      };
    };
  };
}
