{
  config,
  pkgs,
  user,
  ...
}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      # tmuxPlugins.power-theme
      tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      unbind C-a
      set -g prefix C-a
      set -g mouse on

      set-option -g status-position top
# vim mode
      set-window-option -g mode-keys vi

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

# bindings
      bind-key r source-file ~/.tmux.conf
      bind-key '"' split-window -c "#{pane_current_path}"
      bind-key % split-window -h -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"
    '';
  };
}
