# build lua+mongoose+unqlite

CC=gcc
CFLAGS=-c -Ilua
LDFLAGS=-Llua -llua -Llua-cjson -llua-cjson -lws2_32 -s
OBJS=lua-mongoose.o lua-unqlite.o lmu.o mongoose/mongoose.o unqlite/unqlite.o
LUALIB=lua/liblua.a
LUACJSONLIB=lua-cjson/liblua-cjson.a
TARGET=lmu

.PHONY: all clean

$(TARGET):$(OBJS) $(LUALIB) $(LUACJSONLIB)
	$(CC) -o $(TARGET) $(OBJS) $(LDFLAGS)

$(LUALIB):
	cd lua; make generic; cd ..
	
$(LUACJSONLIB):
	cd lua-cjson; make; cd ..
	
clean:
	cd lua; make clean; cd ..; rm -f $(TARGET) $(OBJS)
