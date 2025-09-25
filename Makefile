SRC_MD = cv.md
TEMPLATE = template.html
OUT_DIR = build
OUT_HTML = $(OUT_DIR)/index.html
CSS = $(OUT_DIR)/style.css

all: $(OUT_HTML) $(CSS)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_HTML): $(SRC_MD) $(TEMPLATE) | $(OUT_DIR)
	pandoc --standalone $(SRC_MD) -o $(OUT_HTML) --template=$(TEMPLATE)

$(CSS): | $(OUT_DIR)
	cp style.css $(CSS)

clean:
	rm -rf $(OUT_DIR)
