#!/bin/bash
# Simple wrapper script for duplicity. It adds profile support to duplicity
# making it easier to maintain different sets of backups. See duply
# (https://duply.net/) for something very similar. This is just a more basic
# version.
#
# Profiles are stored in /etc/bbackup/ or ~/.bbackup/
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

usage() {
	echo "usage: $0 <cmd> <profile>" >&2
	echo "commands: backup|status|restore|clean|fixup|files"
}

if ! duplicity --version > /dev/null 2>&1; then
    echo "error: duplicity not available" >&2
    exit 1
fi

COMMAND=${1}
shift
PROFILE=${1}
shift

DATA_DIR="${HOME}/.bbackup"

if [ -f "/etc/bbackup/${PROFILE}.conf" ]; then
	PROFILE_DIR="/etc/bbackup"
elif [ -f "${HOME}/.bbackup/${PROFILE}.conf" ]; then
	PROFILE_DIR="${HOME}/.bbackup/"
else
	if [ ! -z "${PROFILE}" ]; then
		echo "error: profile ${PROFILE} missing" >&2
	fi
	usage
	exit 1
fi
. ${PROFILE_DIR}/${PROFILE}.conf


if [ ! -d "${SRCDIR}" ]; then
        echo "error: source dir ${SRCDIR} does not exist" >&2
        exit 1
fi

if [ ! -z "${SSHKEY}" ]; then
	if [ ! -f "${SSHKEY}" ]; then
		SSHKEY="${PROFILE_DIR}/${SSHKEY}"
		if [ ! -f "${SSHKEY}" ]; then
			echo "error: could not locate ssh key" >&2
			exit 1
		fi
	fi
fi

mkdir -p "${DATA_DIR}"

CACHE_DIR="${DATA_DIR}/cache-${PROFILE}"
TEMP_DIR="${DATA_DIR}/temp-${PROFILE}"

if [ ! -d "${TEMP_DIR}" ]; then
	mkdir -p ${TEMP_DIR}
fi

DUPOPTS=" \
	--name ${PROFILE} \
	--archive-dir=${CACHE_DIR} \
	--asynchronous-upload \
	--tempdir=${TEMP_DIR} \
"

if [ ! -z "${VERBOSE_BACKUP}" ]; then
    DUPOPTS="${DUPOPTS} --verbosity ${VERBOSE_BACKUP}"
fi

if [ ! -z "${SSHKEY}" ]; then
	DUPOPTS="${DUPOPTS} --ssh-options -oIdentityFile=${SSHKEY}"
fi

if [ ! -z "${GPGKEY}" ]; then
	DUPOPTS="${DUPOPTS} --encrypt-key ${GPGKEY}"
else
	DUPOPTS="${DUPOPTS} --no-encryption"
fi

# Add extra duplicity from profile
DUPOPTS="${DUPOPTS} ${DUPARGS}"

case "${COMMAND}" in
	backup)
		DUPOPTS="${DUPOPTS} ${BKPOPTS} ${SRCDIR} ${TARGET}"
		;;

	status)
		DUPOPTS="${DUPOPTS} collection-status ${TARGET}"
		;;

	clean)
		DUPOPTS="${DUPOPTS} ${CLEANOPTS} ${TARGET}"
		;;

	fixup)
		DUPOPTS="${DUPOPTS} cleanup --force ${TARGET}"
		;;

	files)
		DUPOPTS="${DUPOPTS} list-current-files ${TARGET}"
		;;

	restore)
		DESTDIR=${1}
		shift
		if [ -z "${DESTDIR}" ]; then
			echo "usage: $0 restore ${PROFILE} <dest-dir> [opts]" >&2
			exit 1
		fi
		DUPOPTS="${DUPOPTS} restore $* ${TARGET} ${DESTDIR}"
		;;

 	*)
    	usage
        exit 1
        ;;
esac

echo "Duplicity: ${DUPOPTS}"

if [ ! -z "${ADMIN}" ]; then
	duplicity ${DUPOPTS} 2>&1 | tee /dev/tty | mail -s "bbackup: ${PROFILE}" ${ADMIN}
else
	duplicity ${DUPOPTS}
fi
