{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
    IgnoreUnknown UseKeychain
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
    '';
  };
}