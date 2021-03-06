#!/bin/bash
export LOGNAME=gpadmin
export USER=gpadmin
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
export KRB5CCNAME=DIR:/tmp/krb5_cc
export LDAPCONF=/etc/openldap/ldap.conf
source /usr/local/greenplum-db/greenplum_path.sh
export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH
cp /opt/kerberos/krb5.keytab /home/gpadmin/krb5.keytab
kinit -kt /home/gpadmin/krb5.keytab ${USER_NAME}@${REALM_NAME}

ldappasswd -S -x -D cn=admin,dc=pivotal,dc=io -w changeme uid=${LDAP_USER_NAME},dc=pivotal,dc=io -s ${USER_PASSWORD} -h myldap.com
ldappasswd -S -x -D cn=admin,dc=pivotal,dc=io -w changeme uid=${LDAP_USER_NAME}_tls,dc=pivotal,dc=io -s ${USER_PASSWORD} -h myldap.com
ldappasswd -S -x -D cn=admin,dc=pivotal,dc=io -w changeme uid=${LDAP_USER_NAME}_s,dc=pivotal,dc=io -s ${USER_PASSWORD} -h myldap.com

echo -e "krb_srvname = 'postgres'\ngp_enable_gpperfmon=on\nkrb_server_keyfile = '/home/gpadmin/krb5.keytab'" >> /gpdata/master/gpseg-1/postgresql.conf

gpstart -a
psql -d gpadmin -t -c "create role ${USER_NAME} with login password '${USER_PASSWORD}'; \
                    create role ${LDAP_USER_NAME} with login; \
                    create role ${LDAP_USER_NAME}_tls with login; \
                    create role ${LDAP_USER_NAME}_s with login;"
