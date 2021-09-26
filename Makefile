#
# makefile
#

.PHONY: build install

.DEFAULT_GOAL := build
swift_runtime = `which swift`
product_name = fbconv
release_path = .build/release/$(product_name)
install_path = /usr/local/bin/$(product_name)

build:
	@if [ -n "$(swift_runtime)" ]; then \
	  	$(swift_runtime) build -c release; \
	else \
		echo "fatal: no swift runtime"; \
	fi; \

install: $(release_path)
	@install $(release_path) $(install_path)

