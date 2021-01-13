CXX=g++
CXXFLAGS += -g -pthread -Wall -Wextra
CPPFLAGS += -isystem src -std=c++14

MKDIR_P = mkdir -p
OBJ_DIR = obj

all: malloc_tests main submission

${OBJ_DIR}:
	${MKDIR_P} ${OBJ_DIR}

submission:
	zip -r malloc-submission.zip src

obj/%.o: src/%.cpp ${OBJ_DIR}
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

main: obj/main.o obj/my_malloc.o
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@

obj/malloc_tests.o: test/malloc_tests.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

malloc_tests : obj/my_malloc.o obj/malloc_tests.o /usr/lib/libgtest.a /usr/lib/libgtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@

clean:
	rm -f main malloc_tests test_detail.xml
	rm -rf obj
	rm -f *~ obj/*.o obj/*.a *.zip
