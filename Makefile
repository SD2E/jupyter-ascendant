VERSION=$(shell cat VERSION)

.PHONY: all
all: 
	echo "Making sd2e-jupyter v$(VERSION)"
	chmod a+x bin/*

.PHONY: clean
clean:
	rm -f *.json

.PHONY: install
install:
	install bin/sd2e-jupyter /usr/local/bin

.PHONY: install-user
install-user:
	mkdir -p $(HOME)/cli/bin 
	install bin/sd2e-jupyter $(HOME/)cli/bin
