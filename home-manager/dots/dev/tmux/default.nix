{
  pkgs,
  configName,
  ...
}:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig =
      ''
        unbind C-a
        set -g prefix C-a
        set -g mouse on

        set -g base-index 1
        set -g pane-base-index 1
        set -g status-style bg=default

        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"

        set -g @catppuccin_window_status_style "rounded"
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application} #{E:@catppuccin_status_session}"

        set-option -s set-clipboard off

        set-option -g status-position top
        # vim mode
        set-window-option -g mode-keys vi

        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

        # bindings
        bind-key '"' split-window -c "#{pane_current_path}"
        bind-key % split-window -h -c "#{pane_current_path}"
        bind-key c new-window -c "#{pane_current_path}"
      ''
      + (
        if builtins.match "^wsl.*" configName != null then
          ''
            bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "clip.exe"
            bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "clip.exe"
          ''
        else
          ''
            bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
            bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
          ''
      );

  };
}
