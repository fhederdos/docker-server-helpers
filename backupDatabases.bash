#!/bin/bash

dbBackupPath="/backup/filepath/"

# declare Environments 
# ["docker-container"]="path/to/Environmentfile/.env"
declare -A environments=(
	["docker-container"]="path/to/Environmentfile/.env"
)

extractDatabase() {
	container="$1"
	envFile="$2"

	export $(grep -v '^#' $envFile | xargs)
	/usr/bin/docker exec $container /usr/bin/mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE | gzip > $dbBackupPath$MYSQL_DATABASE.sql.gz
	unset $(grep -v '^#' $envFile | sed -E 's/(.*)=.*/\1/' | xargs)
}

# assoziierte arrays:

for key in "${!environments[@]}";do
	extractDatabase $key ${environments[$key]}
done

