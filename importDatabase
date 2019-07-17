#!/bin/bash

echo "Database File *.sql or *.sql.gz (+path):"
read sqlFile
echo "Environment File (+path)"
read envFile
echo "DB Container Name"
read container

export $(grep -v '^#' $envFile | xargs)

if [ "${sqlFile: -2}" == "gz" ]
then
	zcat $sqlFile | docker exec -i $container /usr/bin/mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE
else
	cat $sqlFile | docker exec -i $container /usr/bin/mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE
fi

unset $(grep -v '^#' $envFile | sed -E 's/(.*)=.*/\1/' | xargs)

