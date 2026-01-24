.PHONY: help docs preview test coverage clean

# Default target
help:
	@echo "Maple Makefile Commands:"
	@echo ""
	@echo "  make docs          - Generate static documentation for hosting"
	@echo "  make preview       - Start documentation preview server"
	@echo "  make test          - Run all tests (macOS)"
	@echo "  make coverage      - Generate code coverage report"
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

# Clean build artifacts and documentation
clean:
	@echo "🧹 Cleaning..."
	@rm -rf .build
	@rm -rf .swiftpm
	@rm -rf docs
	@echo "✅ Cleaned"
