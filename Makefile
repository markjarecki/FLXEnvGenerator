export EXECUTABLE_NAME := envgenerator

BIN_DIR := /usr/local/bin
INSTALL_PATH := $(BIN_DIR)/$(EXECUTABLE_NAME)
BUILD_DIR := .build/

### GENERAL ###
.PHONY: all help install build clean uninstall test

all: help

help: 
	@echo "install - install envgenerator"
	@echo "build - build envgenerator"
	@echo "clean - clean build directory"
	@echo "uninstall - remove envgenerator"
	@echo "test - run envgenerator tests"

install: build
	@echo "Installing envgenerator..."
	mkdir -p $(BIN_DIR)
	cp -f $(BUILD_DIR)release/$(EXECUTABLE_NAME) $(INSTALL_PATH)

build:
	@echo "Building envgenerator..."
	swift build --disable-sandbox -c release

clean:
	@echo "Cleaning build directory..."
	rm -Rf $(BUILD_DIR)

uninstall:
	@echo "Uninstalling..."
	rm -f $(INSTALL_PATH)

test:
	@echo "Running envgenerator tests..."
	swift test


