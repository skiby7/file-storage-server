CWD=$(realpath $(dirname $0))

while true
do
	SMALL_FILE_NUM=$((RANDOM % 100))
	MEDIUM_FILE_NUM=$((RANDOM % 10))
	LARGE_FILE_NUM=$((RANDOM % 5))
	bin/client -f /tmp/socket.sk -W ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -u ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -R 5 -W ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -u ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -W ${CWD}/test_2/initial_file_0.txt -u ${CWD}/test_2/initial_file_0.txt -l ${CWD}/test_2/initial_file_0.txt -c ${CWD}/test_2/initial_file_0.txt -t 0 -p &> /dev/null
	# bin/client -f /tmp/socket.sk -w ${CWD}/small_files/small_${LARGE_FILE_NUM}.txt -u ${CWD}/small_files/small_${LARGE_FILE_NUM}.txt -t 0 
	# bin/client -f /tmp/socket.sk -w ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -u ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -W ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -u ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -W ${CWD}/test_2/initial_file_0.txt -u ${CWD}/test_2/initial_file_0.txt -l ${CWD}/test_2/initial_file_0.txt -c ${CWD}/test_2/initial_file_0.txt -t 0 
	# bin/client -f /tmp/socket.sk -w ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -u ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -W ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -u ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt  -t 500 
	# bin/client -f /tmp/socket.sk -l ${CWD}/test_2/initial_file_0.txt -c ${CWD}/test_2/initial_file_0.txt 
	if [[ $(($RANDOM % 2)) -eq 0 ]]
	then
    	bin/client -f /tmp/socket.sk -l ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -c ${CWD}/small_files/small_${SMALL_FILE_NUM}.txt -p &> /dev/null
	else
    	bin/client -f /tmp/socket.sk -l ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -c ${CWD}/medium_files/medium_${MEDIUM_FILE_NUM}.txt -p &> /dev/null
	fi

	if [[ $(($RANDOM % 10)) -eq 5 ]]
	then
		bin/client -f /tmp/socket.sk -w ${CWD}/medium_files -x -p &> /dev/null
	fi

	if [[ $(($RANDOM % 3)) -eq 1 ]]
	then
		bin/client -f /tmp/socket.sk -w ${CWD}/small_files -x -p &> /dev/null
	fi

	if [[ $(($RANDOM % 100)) -eq 50 ]]
	then
		bin/client -f /tmp/socket.sk -W ${CWD}/large_files/large_${LARGE_FILE_NUM}.txt -u ${CWD}/large_files/large_${LARGE_FILE_NUM}.txt -p &> /dev/null
	fi


done