#! /bin/bash

SID_FILE="$1"
SCRIPT_FILE="$2"
PASSWORD="$3"
PATH=$PATH:${PWD}

if ! [ -r "${SID_FILE}" -a -r "${SCRIPT_FILE}" -a -n "${PASSWORD}" ]; then
    echo -e "\nUsage:\n\t$0 <sid_file> <keys_file> <password>\n" 
    exit 1
fi

if ! which sshpass &>/dev/null; then
    echo "You should copy sshpass to your current or PATH directory"
    exit 1
fi

#KEYS="$(cat ${KEYS_FILE})"
PATH_TO_COPY_SCRIPT=/tmp
#PARTNER_SHARE_AUTH_KEYS=${PARTNER_SHARE_SSH_DIR}/authorized_keys
#PARTNER_SSH_DIR=/home/partner/.ssh
#PARTNER_AUTH_KEYS=${PARTNER_SSH_DIR}/authorized_keys

while read sid; do 
    echo "Running script on $sid..."
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=30 -U root@/home/$sid/tunnels/ssh\
    "cd ${PATH_TO_COPY_SCRIPT};\
    scp $SERIAL_NUMBER@axcient.net:/d*ox/m*ta/s*f/mtime*.sh ."

    #"cd /home/partner || { echo No user partner; exit; };\
    #mount -o remount,rw /;\
    #mkdir -p ${PARTNER_SHARE_SSH_DIR};\
    #if [ -d ${PARTNER_SSH_DIR} -a ! -L ${PARTNER_SSH_DIR} -a -r ${PARTNER_AUTH_KEYS} ]; then\
    #    cat ${PARTNER_AUTH_KEYS} >> ${PARTNER_SHARE_AUTH_KEYS};\
    #fi ;\
    #rm -rf ${PARTNER_SSH_DIR} ;\
    #ln -s ${PARTNER_SHARE_SSH_DIR} ${PARTNER_SSH_DIR} ;\
    #echo \"$KEYS\" >> ${PARTNER_AUTH_KEYS} ;\
    #chmod 600 ${PARTNER_SHARE_AUTH_KEYS} ;\
    #chown partner:partner -R ${PARTNER_SSH_DIR} ${PARTNER_SHARE_SSH_DIR};\
    #mount -o remount,ro /"\
    # </dev/null || echo "Unable to add keys to $sid"
done < $SID_FILE