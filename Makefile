LANG  := C
CYAN  := \033[36m
GREEN := \033[32m
RESET := \033[0m

# http://postd.cc/auto-documented-makefile/
.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "${CYAN}%-30s${RESET} %s\n", $$1, $$2}'

.PHONY: deps
deps: ## Install dependencies
	GO111MODULE=off go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
	GO111MODULE=off go get -u -v golang.org/x/tools/cmd/goimports

lint: ## Lint code
	golangci-lint run

test: ## Test code
	go test -v -race $$(go list ./... | grep -v vendor)

format: ## Format code
	goimports -l -w .

