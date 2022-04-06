
build: $(wildcard *.go)
	go build -o gofunc.so -buildmode=c-shared *.go

run: build
	./main.rb

.PHONY: build run
