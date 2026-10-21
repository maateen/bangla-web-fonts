# Bangla Web Fonts - Local Development Makefile
# Simple Makefile for local serving only

# Directories
FONTS_DIR := fonts
DOCS_DIR := docs

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

.PHONY: generate-index
generate-index: ## Generate fonts/_index.md from README.md
	@echo "$(CYAN)📝 Generating fonts/_index.md from README.md...$(RESET)"
	@mkdir -p $(FONTS_DIR)
	@echo "+++" > $(FONTS_DIR)/_index.md
	@echo 'title = "Bangla Font CDN"' >> $(FONTS_DIR)/_index.md
	@echo 'menuTitle = "Home"' >> $(FONTS_DIR)/_index.md
	@echo "+++" >> $(FONTS_DIR)/_index.md
	@echo "" >> $(FONTS_DIR)/_index.md
	@tail -n +2 README.md >> $(FONTS_DIR)/_index.md
	@echo "$(GREEN)✅ fonts/_index.md generated successfully$(RESET)"

.PHONY: serve
serve: generate-index ## Start Hugo development server with file watching
	@echo "$(CYAN)🚀 Starting Hugo development server with file watching...$(RESET)"
	@echo "$(YELLOW)📁 Watching for changes in: $(FONTS_DIR)/, README.md, $(DOCS_DIR)/$(RESET)"
	@cd $(DOCS_DIR) && hugo server --contentDir ../$(FONTS_DIR) --bind 127.0.0.1 --port 1313 --watch --poll 1s

.PHONY: clean
clean: ## Clean generated files
	@echo "$(CYAN)🧹 Cleaning up...$(RESET)"
	@rm -rf $(DOCS_DIR)/public
	@echo "$(GREEN)✅ Cleanup completed$(RESET)"
