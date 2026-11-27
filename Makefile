MAIN := src/main.typ
OUT_DIR := dist
OUTPUT := $(OUT_DIR)/Математический анализ I семестр — Билеты и план подготовки.pdf

.PHONY: all build watch clean

all: build

build:
	@mkdir -p "$(OUT_DIR)"
	typst compile "$(MAIN)" "$(OUTPUT)"
	@echo "Собран файл: $(OUTPUT)"

watch:
	@mkdir -p "$(OUT_DIR)"
	typst watch "$(MAIN)" "$(OUTPUT)"

clean:
	rm -rf "$(OUT_DIR)"
