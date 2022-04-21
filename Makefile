
_build: $(wildcard *.go)
	go build -o gofunc.so -buildmode=c-shared *.go

_bundle:
	bundle

run: _build _bundle
	./main.rb

.PHONY: _build _bundle run
