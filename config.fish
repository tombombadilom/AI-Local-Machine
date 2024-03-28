# Set Ibus environment variables if you need them
set -gx GTK_IM_MODULE ibus
set -gx XMODIFIERS @im=dbus
set -gx QT_IM_MODULE ibus
set -gx QT_QPA_PLATFORMTHEME qt6ct
set -gx ELECTRON_OZONE_PLATFORM_HINT wayland
set -gx XDG_SESION_TYPE wayland
set -gx QT_QPA_PLATFORM wayland

# Function to check for new git repository
function check_directory_for_new_repository
  # Get the current git repository directory (if any)
  set current_repository (command git rev-parse --show-toplevel 2> /dev/null)

  # Check if there's a current repository and if it's different from the last one
  if test -n "$current_repository" -a "$current_repository" != "$last_repository"
    # Perform the onefetch action (assuming it's a function or command compatible with fish)
    onefetch
  end

  # Update the last_repository variable globally
  set -g last_repository $current_repository
end

# Function to change directory and check for new repository
function cd
  builtin cd $argv
  check_directory_for_new_repository
end

# Optional greeting on startup (call this after sourcing the file)
check_directory_for_new_repository

# Set environment variables for Java and Android SDK
set -gx JAVA_HOME /home/tom/Android/Sdk
set -gx HISTCONTROL ignoreboth:erasedups
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx STUDIO_JDK /home/tom/Android/Sdk

# Add directories to PATH
set -U fish_user_paths $fish_user_paths /home/tom/Android/Sdk

 
if status is-interactive
   # Commands to run in interactive sessions can go here
    set fish_greeting

end

if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias pamcan=pacman
function parse_git_branch
    set -l branch_name (git branch --show-current 2>/dev/null)
    if test -n "$branch_name"
        echo " ($branch_name)"
    end
end

function fish_prompt
    set -l user_color cyan
    set -l host_color yellow
    set -l path_color green
    set -l git_branch (parse_git_branch)

    echo -n (set_color $user_color)(whoami)@(set_color $host_color)(hostname):(set_color $path_color)(prompt_pwd)(set_color normal)$git_branch '$ '
end

function starship_transient_prompt_func
  starship module character
end

starship init fish | source

enable_transience


