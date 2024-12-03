{ agenix, ... }:
{
  imports = [
    agenix.homeManagerModules.default
  ];

  config.age = {
    secrets.terraformrc = {
      file = ../../secrets/terraformrc.age;
      path = "\${HOME}/.terraformrc";
      symlink = false;
    };

    secrets.npmrc = {
      file = ../../secrets/npmrc.age;
      path = "\${HOME}/.npmrc";
      symlink = false;
    };
  };
}
