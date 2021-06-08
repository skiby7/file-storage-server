#define _GNU_SOURCE
#ifndef COMMON_INCLUDES_H
#define COMMON_INCLUDES_H
#include "common_includes.h"
#endif
#ifndef CLIENT_H
#define CLIENT_H
#include "client.h"
#endif

#include "fssApi.h"

#define WRITE_DIR 0x01
#define WRITE_FILES 0x02
#define READ_FILES 0x04
#define READ_N_FILES 0x08
#define LOCK_FILES 0x10
#define UNLOCK_FILES 0x20
#define DELETE_FILES 0x40

#define DELIM ","

typedef struct work{
	unsigned char command;
	char *args;
	struct work *next;
	struct work *prev;
} work_queue;

extern client_conf config;

char *strtok_r(char *str, const char *delim, char **saveptr);
int handle_read_files(char **args);
int handle_simple_request(char **args, unsigned char command);
void do_work(work_queue **head, work_queue **tail);
void enqueue_work(unsigned char command, char *args, work_queue **head, work_queue **tail);
int dequeue_work(unsigned char* command, char **args, work_queue **head, work_queue **tail);