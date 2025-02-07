#!/bin/bash -e

KLIPPO_DEST="${ROOTFS_DIR}/opt/klippo"

if [ ! -d "${KLIPPO_DEST}" ]; then
	rsync -aAXx --mkpath --chown=1000:1000 --exclude='.git*' --filter=':- .gitignore' "${KLIPPO_DIR}/" "${KLIPPO_DEST}"
fi

echo "Running klippo setup script..."
on_chroot << EOF
/opt/klippo/setup/setup_klippo.py -v
EOF
echo "Klippo setup script completed"

# Remove pip cache
rm -rf "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.cache/pip"
