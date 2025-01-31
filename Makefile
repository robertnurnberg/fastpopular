CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O3 -g

NATIVE = -march=native

# Detect Windows
ifeq ($(OS), Windows_NT)
	uname_S  := Windows
else
ifeq ($(COMP), MINGW)
	uname_S  := Windows
else
	uname_S := $(shell uname -s)
endif
endif

ifeq ($(uname_S), Darwin)
	NATIVE =	
endif

SRC_FILE = fastpopular.cpp
EXE_FILE = fastpopular
HEADERS = fastpopular.hpp
EXT_HEADERS = external/chess.hpp external/json.hpp external/threadpool.hpp external/zstr/zstr.hpp external/zstr/strict_fstream.hpp external/parallel_hashmap/phmap.h fastpopular.hpp

all: $(EXE_FILE)

$(EXE_FILE): $(SRC_FILE) $(HEADERS) $(EXT_HEADERS)
	$(CXX) $(CXXFLAGS) $(NATIVE) -o $(EXE_FILE) $(SRC_FILE) -lz -lzstd

format:
	clang-format -i $(SRC_FILE) $(HEADERS)

clean:
	rm -f $(EXE_FILE) $(EXE_FILE).exe
