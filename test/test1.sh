#!/bin/bash

CWD=$(realpath $(dirname $0))

valgrind --fair-sched=yes --leak-check=full bin/server $1 &
# bin/server $1 &
sleep 1
SERVER=$!

echo -e -n "\nAvvio il server"
for i in {0..2}
do
	sleep 1
	echo -n "."
done
sleep 1
echo -e "\n"

# Carico una cartella e occupo un po' di spazio
bin/client -f /tmp/socket.sk -w ${CWD}/small_files,10 -x -p -t 200 
bin/client -f /tmp/socket.sk -w ${CWD}/small_files,10 -x -p -t 200 
bin/client -f /tmp/socket.sk -w ${CWD}/small_files,10 -x -p -t 200 

# Leggo tutti i file caricati
bin/client -f /tmp/socket.sk -R 0 -d ${CWD}/test_output -p -t 200

# Carico un file con -W
bin/client -f /tmp/socket.sk -W ${CWD}/medium_files/medium_0.txt -u ${CWD}/medium_files/medium_0.txt -p -t 200 

# Leggo un file con -r e lo salvo
bin/client -f /tmp/socket.sk -r ${CWD}/medium_files/medium_0.txt -d ${CWD}/test_output -p -t 200 

# Blocco il file per 2 secondi e faccio mettere in attesa un altro client
bin/client -f /tmp/socket.sk -l ${CWD}/medium_files/medium_0.txt -u ${CWD}/medium_files/medium_0.txt -p -t 2000 &

# Cancello il file appena posso bloccarlo 
bin/client -f /tmp/socket.sk -l ${CWD}/medium_files/medium_0.txt -c ${CWD}/medium_files/medium_0.txt -p -t 200 

# Test per verifivare che la compressione funzioni sui file binari
echo -e "\n\x1b[33mEseguo un file binario prima di inviarlo al server\x1b[0m"

${CWD}/binary/binary_test Originale

echo ""

bin/client -f /tmp/socket.sk -W ${CWD}/binary/binary_test -u ${CWD}/binary/binary_test -p -t 200

bin/client -f /tmp/socket.sk -r ${CWD}/binary/binary_test -d ${CWD}/test_output -p -t 200 

echo -e "\n\x1b[33mEseguo il file binario dopo averlo letto dal server\x1b[0m"

${CWD}/test_output${CWD}/binary/binary_test Scaricato

sleep 1

echo ""

kill -1 $SERVER

echo -e -n "\nSIGHUP inviato al server, attendo"

wait $SERVER

exit 0