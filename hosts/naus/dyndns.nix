{ pkgs, config, ... }:
{

  age.secrets."cf-tf/api-key".file = ../../secrets/cf-tf/api-key.age;

  services.ddclient = {
    enable = true;
    ssl = true;
    username = "token";
    protocol = "cloudflare";
    usev4 = "webv4, webv4=https://cloudflare.com/cdn-cgi/trace, web-skip='ip='";
    usev6 = "disabled";
    domains = [ "craft.melon.dance" ];
    passwordFile = config.age.secrets."cf-tf/api-key".path;
    zone = "melon.dance";
  };
}
