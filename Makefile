CC = nim
NIMBLE = nimble

BINDIR = bin
TESTDIR = tests

.PHONY: test
test:
	cd $(TESTDIR) && $(NIMBLE) test --verbose

.PHONY: clean
clean:
	rm -f $(TESTDIR)/test
	rm -f main
	rm -f src/nlog
	rm -f test.log
