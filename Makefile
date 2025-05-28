CC = gcc
CFLAGS = -Wall -O
CLIBS =
#
OS := $(shell uname -s)
ifeq ($(OS), Linux)
	CLIBS += -lpthread
endif
ifeq ($(OS), Darwin)
#	CLIBS +=
endif
#
all: reader_prefer_cond.o writer_prefer_cond.o \
	  writer_prefer_mutex.o fair_reader_writer_mutex.o
	$(CC) -o rpc reader_prefer_cond.o $(CLIBS)
	$(CC) -o wpc writer_prefer_cond.o $(CLIBS)
	$(CC) -o wpm writer_prefer_mutex.o $(CLIBS)
	$(CC) -o frw fair_reader_writer_mutex.o $(CLIBS)

reader_prefer_cond.o: reader_prefer_cond.c
	$(CC) $(CFLAGS) -c reader_prefer_cond.c

writer_prefer_cond.o: writer_prefer_cond.c
	$(CC) $(CFLAGS) -c writer_prefer_cond.c

writer_prefer_mutex.o: writer_prefer_mutex.c
	$(CC) $(CFLAGS) -c writer_prefer_mutex.c

fair_reader_writer.o: fair_reader_writer_mutex.c
	$(CC) $(CFLAGS) -c fair_reader_writer_mutex.c

clean:
	rm -rf *.o
