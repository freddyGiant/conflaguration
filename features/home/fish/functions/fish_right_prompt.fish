set -l color_cwd $fish_color_cwd
if fish_is_root_user; and set -q fish_color_cwd_root
  set color_cwd $fish_color_cwd_root
end

printf (set_color $color_cwd)
