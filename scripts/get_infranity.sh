#!/bin/sh

set -e

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -x "$(command -v git)" ]; then
	echo "\033[91merror: git is not installed.\033[0m" >&2
	exit 1
fi

if [ -e "$HOME/.infranity" ]; then
	while true; do
		printf "\033[93m$HOME/.infranity exists, remove it before installing? [yN] \033[0m"
		read -p "" yn

		case $yn in
			[Yy]*) break ;;
			""|[Nn]*) exit 0 ;;
			*) echo "Please input \"y\" or \"n\"." ;;
		esac
	done

	echo "Removing $HOME/.infranity..." # To be consistent with Git logs.
	rm -rf "$HOME/.infranity"
fi

git clone git@github.com:axieinfinity/infranity.git "$HOME/.infranity"

printf "\033[92m"
cat <<EOF

Installation completed. Please add following lines to your ~/.zshrc or ~/.bashrc:

  export INFRANITY_DIR="\$HOME/.infranity"
  export PATH="\$INFRANITY_DIR/bin:\$PATH"
  source "\$INFRANITY_DIR/scripts/completions.sh"

After that, restart your terminal if you want to see the changes immediately.
Otherwise you can run either ONE of these 2 commands (depending on the shell you are using)
to have the same effect:

  source ~/.zshrc
  source ~/.bashrc

Have a nice day!
EOF
printf "\033[0m"
