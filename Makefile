SMLPKG ?= smlpkg

.PHONY: all
all: lib/github.com/diku-dk/sml-hashtable
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle all

.PHONY: test
test: lib/github.com/diku-dk/sml-hashtable
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle test

.PHONY: clean
clean:
	$(MAKE) -C lib/github.com/diku-dk/sml-pickle clean
	rm -rf MLB *~ .*~

.PHONY: realclean
realclean:
	$(MAKE) clean
	rm -rf lib/github.com/diku-dk/sml-hashtable

lib/github.com/diku-dk/sml-hashtable:
	$(SMLPKG) sync
