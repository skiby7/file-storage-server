#include "log.h"

FILE *logfile;
bool log_available;

int open_log(char *pathname){
	logfile = NULL;
	if((logfile = fopen(pathname, "w")) == NULL){
		log_available = false;
		fprintf(stderr, ANSI_COLOR_RED"Impossibile %s! La sessione non verrà registrata.\n", pathname);
		return 0;
	}
	log_available = true;
	return 1;

}

int write_to_log(char *msg){
	char timestamp[80];
	time_t time_;
	struct tm *lcltime = NULL;
	if(log_available){
		memset(timestamp, 0, 80);
		time(&time_);
		lcltime = localtime(&time_);
		strftime(timestamp, 80, "%d-%m-%Y %X %Z", lcltime);
		fprintf(logfile, "[%s] %s\n", timestamp, msg);
		return 0;
	}
	return 1;
}

int close_log(){
	if(log_available){
		fclose(logfile);
		return 0;	
	}
	return 1;
}