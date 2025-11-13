OBJ = filename1.o filename2.o

CXX = g++
CFLAGS = -c
SRC = $(HOME)/Documents/Uni/Algoritmi/Lib
VPATH = ./:$(SRC)
INCLUDE_DIRS = -I./ -I$(SRC)
LDFLAGS = -lm

test: $(OBJ)
	$(CXX) $(OBJ) $(LDFLAGS) -o $@

%.o: %.cpp
	$(CXX) $(CFLAGS) $(INCLUDE_DIRS) $<

clean: 
	@rm -f *.o 
	@echo make clean: done
