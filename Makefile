.PHONY: \
	iphone ipad ios mac tv watch \
	assets \
	build

define ACTOOL
xcrun actool \
	--output-format human-readable-text \
	--notices \
	--warnings
endef

ASSETS := "Assets.car"
DATA := "acextractTests/data"

all:
	
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
ARCHIVE := acextract.xcarchive
build:
	-rm -r ${ARCHIVE}
	xcodebuild \
		-project acextract.xcodeproj \
		-scheme acextract \
		-archivePath ${PWD}/$(ARCHIVE) \
		archive | xcpretty -c
	cp $(ARCHIVE)/Products/usr/local/bin/acextract ${PWD}/acextract.bin
