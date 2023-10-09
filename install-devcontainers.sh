#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
# set -eu

# if ! chezmoi="$(command -v chezmoi)"; then
# 	bin_dir="${HOME}/.local/bin"
# 	chezmoi="${bin_dir}/chezmoi"
# 	echo "Installing chezmoi to '${chezmoi}'" >&2
# 	if command -v curl >/dev/null; then
# 		chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
# 	elif command -v wget >/dev/null; then
# 		chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
# 	else
# 		echo "To install chezmoi, you must have curl or wget installed." >&2
# 		exit 1
# 	fi
# 	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
# 	unset chezmoi_install_script bin_dir
# fi

# # POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
# script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# set -- init --apply --source="${script_dir}"

# echo "Running 'chezmoi $*'" >&2
# # exec: replace current process with chezmoi
# exec "$chezmoi" "$@"

#!/usr/bin/env bash

# Exit on error
set -o errexit
# Exit on error inside any functions or subshells
set -o errtrace

# Install chezmoi if not installed
if ! [ -x "$(command -v chezmoi)" ]; then
    sudo BINDIR=/usr/local/bin sh -c "$(wget -O- https://git.io/chezmoi)"
fi

# Create dotfiles directory
mkdir -p ~/.local/share/chezmoi

# Install dotfiles
chezmoi apply --force