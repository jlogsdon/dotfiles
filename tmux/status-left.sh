#!/usr/bin/env bash
#Print the status-left for tmux.
#
# The powerline root directory.
cwd=$HOME/.tmux-powerline

# Source global configurations.
source "${cwd}/config.sh"

# Source lib functions.
source "${cwd}/lib.sh"

segments_path="${cwd}/${segments_dir}"

# Mute this statusbar?
mute_status_check "left"

# Segments

declare -A tmux_session_info
tmux_session_info+=(["script"]="${segments_path}/tmux_session_info.sh")
tmux_session_info+=(["foreground"]="colour234")
tmux_session_info+=(["background"]="colour148")
tmux_session_info+=(["separator"]="${separator_right_bold}")
#tmux_session_info+=(["separator_fg"]="default")
register_segment "tmux_session_info"

declare -A hostname
hostname+=(["script"]="${segments_path}/hostname.sh")
hostname+=(["foreground"]="colour0")
hostname+=(["background"]="colour33")
hostname+=(["separator"]="${separator_right_bold}")
register_segment "hostname"

declare -A ifstat
ifstat+=(["script"]="${segments_path}/ifstat.sh")
#ifstat+=(["script"]="${segments_path}/ifstat_sys.sh")
ifstat+=(["foreground"]="colour255")
ifstat+=(["background"]="colour30")
ifstat+=(["separator"]="${separator_right_bold}")
#register_segment "ifstat"

declare -A lan_ip
lan_ip+=(["script"]="${segments_path}/lan_ip.sh")
lan_ip+=(["foreground"]="colour255")
lan_ip+=(["background"]="colour24")
lan_ip+=(["separator"]="${separator_right_bold}")
register_segment "lan_ip"

declare -A wan_ip
wan_ip+=(["script"]="${segments_path}/wan_ip.sh")
wan_ip+=(["foreground"]="colour255")
wan_ip+=(["background"]="colour24")
wan_ip+=(["separator"]="${separator_right_thin}")
wan_ip+=(["separator_fg"]="white")
register_segment "wan_ip"

# Print the status line in the order of registration above.
print_status_line_left

exit 0

