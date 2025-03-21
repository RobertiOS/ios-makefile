TMP_FOLDER := .tmp

.PHONY: setup-mise
setup-mise:
	curl https://mise.run | sh
	echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

.PHONY: setup
setup: setup-mise

.PHONY: format
format:
	mise install
	swiftformat .
	swiftlint --quiet --no-cache --fix

.PHONY: lint
lint:
	mise install
	swiftformat --lint .
	swiftlint --quiet --strict --no-cache
	markdownlint .

.PHONY: clean
clean:
	tuist clean
	rm -rf .build
	rm -rf .swiftpm/xcode/package.xcworkspace
	rm -rf .xcresults
	rm -rf *.doccarchive
	rm -rf *.xcodeproj
	rm -rf *.xcworkspace
	rm -rf *.xcframework
	rm -f *.podspec
	rm -rf Derived
	rm -rf Package.resolved
	rm -rf $(TMP_FOLDER)

.PHONY: open
open:
	mise install
	DEV=true tuist generate

.PHONY: generate
generate:
	mise install
	tuist generate --no-open

.PHONY: build-and-test
build-and-test:
	make setup
	make generate
	set -o pipefail && \
	xcodebuild \
		-scheme ios-makefile \
		-workspace ios-makefile.xcworkspace \
		-destination "platform=iOS Simulator,name=iPhone 16 Pro Max,OS=18.2" \
		-derivedDataPath Build/ \
		-enableCodeCoverage YES \
		-allowProvisioningUpdates \
		-verbose \
		test

