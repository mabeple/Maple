.PHONY: help docs preview test coverage clean lint release

# Default target
help:
	@echo "Maple Makefile Commands:"
	@echo ""
	@echo "  make docs          - Generate static documentation for hosting"
	@echo "  make preview       - Start documentation preview server"
	@echo "  make test          - Run all tests (macOS)"
	@echo "  make coverage      - Generate code coverage report"
	@echo "  make lint          - Validate CocoaPods podspec"
	@echo "  make release VERSION=X - Release to CocoaPods (e.g., VERSION=1.3.6)"
	@echo "  make clean         - Clean build artifacts"
	@echo ""

# Generate static documentation for hosting
docs:
	@echo "📚 Generating documentation..."
	@swift package --disable-sandbox generate-documentation --target Maple --output-path ./docs --transform-for-static-hosting --hosting-base-path Maple
	@echo "✅ Documentation generated at ./docs"

# Generate and preview documentation
preview:
	@echo "🌐 Starting documentation preview server..."
	@swift package --disable-sandbox preview-documentation --target Maple

# Run tests (macOS)
test:
	@echo "🧪 Running macOS tests..."
	@swift test --parallel
	@echo "✅ macOS tests completed"

# Generate code coverage
coverage:
	@echo "🧪 Running tests with code coverage..."
	@swift test --enable-code-coverage
	@echo "✅ Coverage report generated"

# Validate CocoaPods podspec
lint:
	@echo "🔍 Validating CocoaPods podspec..."
	@bundle exec fastlane ios pod_repo_validate
	@echo "✅ Podspec validation completed"

# Release to CocoaPods Trunk
# Usage: make release VERSION=1.3.6
release:
	@if [ -z "$(VERSION)" ]; then \
		echo "❌ Error: VERSION is required. Usage: make release VERSION=1.3.6"; \
		exit 1; \
	fi
	@echo "🚀 Releasing version $(VERSION) to CocoaPods Trunk..."
	@fastlane ios pod_repo_push version:$(VERSION)
	@echo "✅ Release $(VERSION) completed"

# Clean build artifacts and documentation
clean:
	@echo "🧹 Cleaning..."
	@rm -rf .build
	@rm -rf .swiftpm
	@rm -rf docs
	@echo "✅ Cleaned"
