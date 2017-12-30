# Go parameters
GOCMD=go
GOARCH=amd64
GOBUILD=$(GOCMD) build -tags="gocql_debug"
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY=emissary
BINARY_UNIX=$(BINARY)_unix

all: test build
build: 
	$(GOBUILD) -o $(BINARY) -v cmd/main.go
darwin:
	GOOS=darwin GOARCH=${GOARCH} ${GOBUILD} -o ${BINARY}-linux-${GOARCH} -v cmd/main.go 
linux:
	GOOS=linux GOARCH=${GOARCH} ${GOBUILD} -o ${BINARY}-linux-${GOARCH} -v cmd/main.go 
test: 
	$(GOTEST) -v ./...
clean: 
	$(GOCLEAN)
	rm -f $(BINARY)
	rm -f $(BINARY_UNIX)
run:
	$(GOBUILD) -o $(BINARY) -v ./...
	./$(BINARY)
deps:
	$(GOGET) github.com/gin-gonic/gin 
	$(GOGET) github.com/gocql/gocql 


# Cross compilation
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) -v
