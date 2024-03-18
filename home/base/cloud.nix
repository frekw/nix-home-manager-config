{pkgs, pkgs-old-tf, ...}: {
  home.packages = with pkgs; [
    fluxcd
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm pkgs.google-cloud-sdk.components.bigtable pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
    krew
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    microplane
    sloth
    sops
    pkgs-old-tf.terraform
  ];
}