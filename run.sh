#!/bin/sh

#docker run -p 5432:5432 -d -v /mnt/git/ods/ImportTool:/usr/src/ImportTool -v /mnt/git/ods/data/:/usr/src/ImportTool/data ods-postgres-db-img

#RUN IN CONTAINER:
#psql -U postgres -c "CREATE DATABASE openods OWNER postgres;"
#cd /usr/src/ImportTool
#python3 import.py -d postgres -l -c postgresql://postgres@localhost/openods --verbose


MAX_ATTEMPTS=10
ATTEMPT=0
IS_CREATED=1
while [[ ${ATTEMPT} -lt ${MAX_ATTEMPTS} ]]
do
   psql -U postgres -c "CREATE DATABASE openods OWNER postgres;"
   if [[ $? -eq 0 ]]
   then
     IS_CREATED=0
     break
   fi
   ATTEMPT=$((ATTEMPT + 1))
   echo "Unable to create database. ${ATTEMPT}/${MAX_ATTEMPTS}"
   sleep 5
done

if [[ ${IS_CREATED} -ne 0 ]]
then
    echo "ERROR: Unable to create openods database."
    exit 1
fi

python3 ./import.py -d postgres -l -c postgresql://postgres@localhost/openods \
  -x ../ods-data/fullfile.zip -s ../ods-data/ancilliary.zip --verbose
