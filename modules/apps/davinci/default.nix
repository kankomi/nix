{davinci-pkgs, ...}: {
  home.programs = with davinci-pkgs; [
    davinci-resolve-studio
  ];
}
