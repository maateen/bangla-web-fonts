# Bangla Web Fonts - Local Development Makefile
# Simple Makefile for local serving only

# Directories
FONTS_DIR := fonts
DOCS_DIR := docs
CONTENT_FONTS_DIR := $(DOCS_DIR)/content/fonts

# Colors for output
CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RESET := \033[0m

# Default target
.DEFAULT_GOAL := serve

.PHONY: help
help: ## Show available commands
	@echo "$(CYAN)Bangla Web Fonts - Local Development$(RESET)"
	@echo ""
	@echo "$(YELLOW)Available commands:$(RESET)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: serve
serve: ## Start Hugo development server
	@echo "$(CYAN)🔗 Creating symbolic link from docs/content to fonts...$(RESET)"
	@rm -rf $(CONTENT_FONTS_DIR)
	@ln -sf ../../$(FONTS_DIR) $(CONTENT_FONTS_DIR)
	@echo "$(CYAN)🚀 Starting Hugo development server...$(RESET)"
	@cd $(DOCS_DIR) && hugo server --bind 127.0.0.1 --port 1313

.PHONY: clean
clean: ## Clean generated files
	@echo "$(CYAN)🧹 Cleaning up...$(RESET)"
	@rm -rf $(DOCS_DIR)/public
	@echo "$(GREEN)✅ Cleanup completed$(RESET)"
