
.PHONY: all
all:
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle all

.PHONY: test
test:
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle test

.PHONY: clean
clean:
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle clean
	rm -rf MLB *~ .*~
