.DEFAULT_GOAL := help
BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)
FASTLANE=$(BUNDLE) exec fastlane

#Setup
install: ## install required dependencies
	$(BUNDLE) install
	$(FASTLANE) pod_install

#Tests
test: ## run unit tests
	$(FASTLANE) test

#Helpers
coverage_report: ## generates coverage report using Slather
	$(FASTLANE) generate_slather_report
	open fastlane/test_output/index.html

lint: ## runs swiftlint using autocorrect mode
	swiftlint --fix

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
