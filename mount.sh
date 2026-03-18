#!/usr/bin/env bash

SANDBOX=/sandbox
MERGED=$SANDBOX/merged
UPPER=$SANDBOX/upper
WORK=$SANDBOX/work

cleanup() {
	echo ">> Cleaning previous mounts"

	for dir in /dev /proc /sys /run; do
		if mountpoint -q "$MERGED$dir"; then
				umount -l "$MERGED$dir"
		fi
	done

	if mountpoint -q "$MERGED"; then
		umount -l "$MERGED"
	fi
}

prepare_dirs() {
	mkdir -p "$MERGED" "$UPPER" "$WORK"
}

reset_overlay() {
	echo ">> Resetting overlay"

	rm -rf "${MERGED:?}/"*
	rm -rf "${UPPER:?}/"*
	rm -rf "${WORK:?}/"*
}

mount_overlay() {
	echo ">> Mounting overlay"

	mount -t overlay overlay -o lowerdir=/,upperdir="$UPPER",workdir="$WORK" "$MERGED"
}

mount_system_dirs() {
	echo ">> Binding system directories"

	for dir in /dev /proc /sys /run; do
		mount --bind "$dir" "$MERGED$dir"
	done
}

mount_pacman_cache() {
	echo ">> Sharing pacman cache"

	mkdir -p "$MERGED/var/cache/pacman"
	mount --bind /var/cache/pacman "$MERGED/var/cache/pacman"
}

enter_chroot() {
	echo ">> Entering sandbox"

	chroot "$MERGED" /usr/bin/env -i HOME=/root PS1="( chroot ) ${PS1}" PATH=/usr/bin:/usr/sbin:/bin:/sbin /bin/bash --login
}

[[ ${1} == "-c" ]] && {
	cleanup
	exit 0
}

[[ ${1} == "-s" ]] && {
	cleanup
	prepare_dirs
	reset_overlay
	mount_overlay
	mount_system_dirs
	mount_pacman_cache
	enter_chroot
}

[[ ${1} == "-m" ]] && {
	echo ">> Generating INITCPIO"
	mkinitcpio -p linux-preview
}

exit 0
