#!/usr/bin/env bash
# shellcheck disable=SC2034
scripts="$(dirname "$0")"
package="nwg-shell"
log_dir="$scripts/log"
log_file="$log_dir/$package.log"

echo "Entering $package..." | tee  "$log_file"

if ! dpkg -s python3-setuptools >/dev/null 2>&1; then
    echo "Installing python3-setuptools..." | tee -a "$log_file"
    sudo apt install -y python3-setuptools | tee -a "$log_file" 2>&1
fi
# Function to print log messages
function log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") $1" | tee -a "$log_file"
}

# Function to print progress bar
function print_progress() {
    local progress=$1
    local total=$2
    local percentage=$((progress * 100 / total))
    local bar_length=20
    local completed_length=$((bar_length * percentage / 100))
    local remaining_length=$((bar_length - completed_length))

    printf "["
    printf "%${completed_length}s" | tr ' ' '#'
    printf "%${remaining_length}s" | tr ' ' ' '
    printf "] %d%%\r" "$percentage"
}

log_message "Installing nwg-shell..."
echo "Installing nwg-shell..." | tee -a "$log_file"
git clone https://github.com/nwg-piotr/nwg-shell.git | tee -a "$log_file" 2>&1
cd nwg-shell || exit
chmod +x setup.py

log_message "Running setup.py..."
echo "Running setup.py..." | tee -a "$log_file"
sudo python3 setup.py install | tee -a "$log_file" 2>&1

# Uninstallation of development libraries
log_message "Uninstalling development libraries..."
echo "Uninstalling development libraries..." | tee -a "$log_file"
sudo apt remove -y python3-setuptools | tee -a "$log_file" 2>&1
sudo apt auto-remove -y | tee -a "$log_file" 2>&1

cd ../
sudo rm -rf nwg-shell

log_message "Installation complete."
echo "Installation complete." | tee -a "$log_file"