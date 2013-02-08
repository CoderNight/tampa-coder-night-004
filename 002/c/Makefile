CFLAGS=-Wall

all: cave

clean:
	rm -f cave out.txt

out.txt: cave
	./cave ../caves/complex_cave.txt > out.txt

test: out.txt
	if diff out.txt ../caves/complex_out.txt ;\
		then echo "\n\x1b[01;32mPass\x1b[0m" ;\
		else echo "\n\x1b[01;31mFail\x1b[0m" ;\
	fi;
