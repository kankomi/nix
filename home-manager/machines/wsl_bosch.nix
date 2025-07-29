{
  config,
  pkgs,
  ...
}:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../dots/zsh
    ../dots/dev/git
    ../dots/dev/tmux
    ../dots/nixvim
    ../dots/btop
  ];
  # Home Manager needs a bit of inffrmation about you and the paths it should
  # manage.
  home.username = "gpa9bh";
  home.homeDirectory = "/home/${config.home.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # configure nixvim
  myapps.nixvim = {
    enable = true;
    featureWebDev = true;
    featureGo = true;
    featurePython = true;
    featureCopilot = true;
    featureTerraform = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # shell
    tldr
    fastfetch

    # Development
    # rustup
    cargo
    zig
    devenv

    age

    # tools
    # azure-cli
    azure-functions-core-tools
    ffmpeg

    claude-code

    # libraries
    libcxx

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # ".zshrc".source = dotfiles/zshrc/.zshrc;
    # ".tmux.conf".source = dotfiles/tmux/.tmux.conf;
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/dotfiles/nvim/.config/nvim";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gpa9bh/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    http_proxy = "http://wsl-proxy:3129";
    https_proxy = "http://wsl-proxy:3129";
    HTTP_PROXY = "http://wsl-proxy:3129";
    HTTPS_PROXY = "http://wsl-proxy:3129";
    NO_PROXY = "localhost,*bosch.com,127.0.0.1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
