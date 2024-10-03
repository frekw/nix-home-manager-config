{ pkgs, pkgs-old-tf, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    (google-cloud-sdk.withExtraComponents [

      (
        if pkgs.stdenv.hostPlatform.isDarwin then
          google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm
        else
          google-cloud-sdk.components.gke-gcloud-auth-plugin-linux-x86_64
      )

      pkgs.google-cloud-sdk.components.bigtable
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    krew
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    microplane
    skopeo
    sloth
    sops
    spicedb-zed
    pkgs-old-tf.terraform
  ];
}
