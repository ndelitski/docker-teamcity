#!/bin/bash
set -e

mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc $TEAMCITY_DATA_PATH/config
jdbc_download_url=https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_4.2.6420.100_enu.tar.gz
wget -P /tmp $jdbc_download_url

tar zxvf /tmp/sqljdbc_4.2.6420.100_enu.tar.gz -C /tmp

cp /tmp/sqljdbc_4.2/enu/sqljdbc4.jar $TEAMCITY_DATA_PATH/lib/jdbc/

cat << EOF > $TEAMCITY_DATA_PATH/config/database.properties
connectionUrl=jdbc:sqlserver://$TEAMCITY_SQLSEVER_HOST:${TEAMCITY_SQLSEVER_PORT:-1433};databaseName=${TEAMCITY_SQLSEVER_DATABASE:-teamcity}
connectionProperties.user=${TEAMCITY_SQLSEVER_USER:-teamcity}
connectionProperties.password=$TEAMCITY_SQLSEVER_PASSWORD
EOF

echo "Starting teamcity..."
exec /opt/TeamCity/bin/teamcity-server.sh run
