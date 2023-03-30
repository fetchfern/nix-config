# i3 config file (v4)
# vim:ft=i3config

font pango:monospace 16
default_border pixel 2
default_floating_border none
focus_follows_mouse yes
mouse_warping none 
workspace_layout default

client.focused #000000 #1e1e2e #000000 #8b66a7 #8b66a7
client.unfocused #000000 #1e1e2e #000000 #000000 #00000000
client.background #1e1e2e

set $m Mod4
bindsym $m+Return exec kitty
bindsym $m+q exec firefox
bindsym $m+w kill
bindsym $m+Shift+r reload
bindsym $m+h focus left
bindsym $m+j focus down
bindsym $m+k focus up
bindsym $m+l focus right
bindsym $m+Shift+h move left
bindsym $m+Shift+j move down
bindsym $m+Shift+k move up
bindsym $m+Shift+l move right
bindsym $m+r mode resize
bindsym $m+1 workspace 1
bindsym $m+2 workspace 2
bindsym $m+3 workspace 3
bindsym $m+4 workspace 4
bindsym $m+5 workspace 5
bindsym $m+6 workspace 6
bindsym $m+7 workspace 7
bindsym $m+8 workspace 8
bindsym $m+9 workspace 9
bindsym $m+Shift+1 move container to workspace 1
bindsym $m+Shift+2 move container to workspace 2
bindsym $m+Shift+3 move container to workspace 3
bindsym $m+Shift+4 move container to workspace 4
bindsym $m+Shift+5 move container to workspace 5
bindsym $m+Shift+6 move container to workspace 6
bindsym $m+Shift+7 move container to workspace 7
bindsym $m+Shift+8 move container to workspace 8
bindsym $m+Shift+9 move container to workspace 9

gaps inner 15
gaps outer 0
smart_gaps off

mode "resize" {
  bindsym Return mode default
  bindsym h resize shrink width 2 px or 2 ppt
  bindsym j resize shrink height 2 px or 2 ppt
  bindsym k resize grow height 2 px or 2 ppt
  bindsym l resize grow width 2 px or 2 ppt
}

exec --no-startup-id i3-msg workspace 7
exec --no-startup-id polybar top
