SRC_MD = cv.md
TEMPLATE = template.html
OUT_DIR = build
OUT_HTML = $(OUT_DIR)/index.html

all: $(OUT_HTML)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# Copy CSS
$(OUT_DIR)/style.css: style.css | $(OUT_DIR)
	cp style.css $(OUT_DIR)/style.css

# Copy QR code
$(OUT_DIR)/qrcode.svg: qrcode.svg | $(OUT_DIR)
	cp qrcode.svg $(OUT_DIR)/qrcode.svg

# Generate HTML from Markdown
$(OUT_HTML): $(SRC_MD) $(TEMPLATE) $(OUT_DIR)/style.css $(OUT_DIR)/qrcode.svg | $(OUT_DIR)
	pandoc --standalone $(SRC_MD) \
		--output=$(OUT_HTML) \
		--template=$(TEMPLATE)

clean:
	rm -rf $(OUT_DIR)
