.PHONY: \
	iphone ipad ios mac tv watch \
	assets \
	build test \
	zip release

define ACTOOL
xcrun actool \
	--output-format human-readable-text \
	--notices \
	--warnings
endef

ASSETS := "Assets.car"
DATA := "acextractTests/data"

all:

# Builad assets
assets: iphone ipad ios mac tv watch

iphone:
	# --filter-for-device-model iPhone8,2
	# --filter-for-device-os-version 9.3
	# --platform iphonesimulator
	$(ACTOOL) \
		--compress-pngs \
		--enable-on-demand-resources YES \
		--minimum-deployment-target 9.3 \
		--platform iphoneos \
		--target-device iphone \
		--compile $(PWD) \
		Images.xcassets
	mv $(ASSETS) $(DATA)/assets_iphone.car

ipad:
	# --filter-for-device-model iPhone8,2
	# --filter-for-device-os-version 9.3
	# --platform iphonesimulator
	$(ACTOOL) \
		--compress-pngs \
		--enable-on-demand-resources YES \
		--minimum-deployment-target 9.3 \
		--platform iphoneos \
		--target-device ipad \
		--compile $(PWD) \
		Images.xcassets
	mv $(ASSETS) $(DATA)/assets_ipad.car

ios:
	# --filter-for-device-model iPhone8,2
	# --filter-for-device-os-version 9.3
	# --platform iphonesimulator
	$(ACTOOL) \
		--compress-pngs \
		--enable-on-demand-resources YES \
		--minimum-deployment-target 9.3 \
		--platform iphoneos \
		--target-device ipad \
		--target-device iphone \
		--compile $(PWD) \
		Images.xcassets
	cp $(ASSETS) $(DATA)/assets.car
	mv $(ASSETS) $(DATA)/assets_ios.car

mac:
	$(ACTOOL) \
		--enable-on-demand-resources NO \
		--minimum-deployment-target 10.11 \
		--platform macosx \
		--target-device mac \
		--compile $(PWD) \
		Images.xcassets
	mv $(ASSETS) $(DATA)/assets_mac.car

tv:
	# --platform appletvsimulator
	# --filter-for-device-model AppleTV5,3
	# --filter-for-device-os-version 9.2
	$(ACTOOL) \
		--compress-pngs \
		--enable-on-demand-resources YES \
		--minimum-deployment-target 9.2 \
		--platform appletvos \
		--target-device tv \
		--compile $(PWD) \
		Images.xcassets
	mv $(ASSETS) $(DATA)/assets_tv.car

watch:
	# --platform watchsimulator
	# --filter-for-device-model iPhone8,2
	# --filter-for-device-os-version 9.3
	$(ACTOOL) \
		--compress-pngs \
		--enable-on-demand-resources NO \
		--minimum-deployment-target 2.2 \
		--platform watchos \
		--target-device watch \
		--compile $(PWD) \
		Images.xcassets
	mv $(ASSETS) $(DATA)/assets_watch.car

# Build app
PROJECT := acextract.xcodeproj
SCHEME := acextract
ARCHIVE := acextract.xcarchive
ACEXTRACT_BIN_PATH := $(ARCHIVE)/Products/usr/local/bin/acextract
build:
	-rm -r $(ARCHIVE)
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-archivePath $(PWD)/$(ARCHIVE) \
		archive | xcpretty -c
	-rm $(PWD)/acextract.bin
	cp $(ACEXTRACT_BIN_PATH) $(PWD)/acextract.bin

# Run unit tests
test:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		test | xcpretty -c

# Build and prepare ZIP file for release
ZIP := acextract.zip
zip: build
	-rm $(ZIP)
	zip -j $(ZIP) $(ACEXTRACT_BIN_PATH)

# Release shourtcut
release: test zip
