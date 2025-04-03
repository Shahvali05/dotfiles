CONFIG_PATH := $(shell pwd)/configuration.nix

rebuild:
	sudo nixos-rebuild switch -I nixos-config=$(CONFIG_PATH)

test:
	nixos-rebuild test -I nixos-config=$(CONFIG_PATH)

dry:
	nixos-rebuild dry-run -I nixos-config=$(CONFIG_PATH)

.PHONY: rebuild test dry
