ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR := build

.PHONY: \
	all \
	build \
	clean \
	help \
	install \
	pr-01 \
	pr-02 \
	pr-03 \
	pr-04 \
	pr-05 \
	pr-06 \
	pr-07 \
	pr-08 \
	pr-09 \
	pr-10 \
	pr-11 \
	pr-12 \
	pr-13 \
	pr-14 \
	pr-15 \
	pr-16 \
	pr-17 \
	pr-19

all: build

build: \
	pr-01 \
	pr-02 \
	pr-03 \
	pr-04 \
	pr-05 \
	pr-06 \
	pr-07 \
	pr-08 \
	pr-09 \
	pr-10 \
	pr-11 \
	pr-12 \
	pr-13 \
	pr-14 \
	pr-15 \
	pr-16 \
	pr-17 \
	pr-19

install: build
	mkdir -p "$(PREFIX)/presentations"
	cp "$(BUILD_DIR)/pr-01.pdf" "$(PREFIX)/presentations/01-intro.pdf"
	cp "$(BUILD_DIR)/pr-02.pdf" "$(PREFIX)/presentations/02-phases-of-translation.pdf"
	cp "$(BUILD_DIR)/pr-03.pdf" "$(PREFIX)/presentations/03-fundamental-types.pdf"
	cp "$(BUILD_DIR)/pr-04.pdf" "$(PREFIX)/presentations/04-variables.pdf"
	cp "$(BUILD_DIR)/pr-05.pdf" "$(PREFIX)/presentations/05-conditional-statement.pdf"
	cp "$(BUILD_DIR)/pr-06.pdf" "$(PREFIX)/presentations/06-loops.pdf"
	cp "$(BUILD_DIR)/pr-07.pdf" "$(PREFIX)/presentations/07-pointers-and-references.pdf"
	cp "$(BUILD_DIR)/pr-08.pdf" "$(PREFIX)/presentations/08-arrays.pdf"
	cp "$(BUILD_DIR)/pr-09.pdf" "$(PREFIX)/presentations/09-functions.pdf"
	cp "$(BUILD_DIR)/pr-10.pdf" "$(PREFIX)/presentations/10-type-conversions.pdf"
	cp "$(BUILD_DIR)/pr-11.pdf" "$(PREFIX)/presentations/11-structures-and-classes.pdf"
	cp "$(BUILD_DIR)/pr-12.pdf" "$(PREFIX)/presentations/12-inheritance.pdf"
	cp "$(BUILD_DIR)/pr-13.pdf" "$(PREFIX)/presentations/13-exceptions.pdf"
	cp "$(BUILD_DIR)/pr-14.pdf" "$(PREFIX)/presentations/14-dynamic-dispatch.pdf"
	cp "$(BUILD_DIR)/pr-15.pdf" "$(PREFIX)/presentations/15-templates.pdf"
	cp "$(BUILD_DIR)/pr-16.pdf" "$(PREFIX)/presentations/16-standard-library.pdf"
	cp "$(BUILD_DIR)/pr-17.pdf" "$(PREFIX)/presentations/17-streams.pdf"
	cp "$(BUILD_DIR)/pr-19.pdf" "$(PREFIX)/presentations/19-algorithms.pdf"

clean:
	rm -rf $(BUILD_DIR)

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "install\tinstall all presentations and homeworks\n"
	@printf "pr-01\tbuild presentation pr-01.pdf\n"
	@printf "pr-02\tbuild presentation pr-02.pdf\n"
	@printf "pr-03\tbuild presentation pr-03.pdf\n"
	@printf "pr-04\tbuild presentation pr-04.pdf\n"
	@printf "pr-05\tbuild presentation pr-05.pdf\n"
	@printf "pr-06\tbuild presentation pr-06.pdf\n"
	@printf "pr-07\tbuild presentation pr-07.pdf\n"
	@printf "pr-08\tbuild presentation pr-08.pdf\n"
	@printf "pr-09\tbuild presentation pr-09.pdf\n"
	@printf "pr-10\tbuild presentation pr-10.pdf\n"
	@printf "pr-11\tbuild presentation pr-11.pdf\n"
	@printf "pr-12\tbuild presentation pr-12.pdf\n"
	@printf "pr-13\tbuild presentation pr-13.pdf\n"
	@printf "pr-14\tbuild presentation pr-14.pdf\n"
	@printf "pr-15\tbuild presentation pr-15.pdf\n"
	@printf "pr-16\tbuild presentation pr-16.pdf\n"
	@printf "pr-17\tbuild presentation pr-17.pdf\n"
	@printf "pr-19\tbuild presentation pr-19.pdf\n"

pr-01: pr-01.pdf
pr-02: pr-02.pdf
pr-03: pr-03.pdf
pr-04: pr-04.pdf
pr-05: pr-05.pdf
pr-06: pr-06.pdf
pr-07: pr-07.pdf
pr-08: pr-08.pdf
pr-09: pr-09.pdf
pr-10: pr-10.pdf
pr-11: pr-11.pdf
pr-12: pr-12.pdf
pr-13: pr-13.pdf
pr-14: pr-14.pdf
pr-15: pr-15.pdf
pr-16: pr-16.pdf
pr-17: pr-17.pdf
pr-19: pr-19.pdf

# Кодовые файлы листингов (minted) — рекурсивно до 3 уровней вложенности;
# GNU make не поддерживает рекурсивные wildcard, поэтому уровни расписаны явно.
define pdf_deps
	$(wildcard Presentations/$1/*.cpp) \
	$(wildcard Presentations/$1/*.h) \
	$(wildcard Presentations/$1/*.hpp) \
	$(wildcard Presentations/$1/*/*.cpp) \
	$(wildcard Presentations/$1/*/*.h) \
	$(wildcard Presentations/$1/*/*.hpp) \
	$(wildcard Presentations/$1/*/*/*.cpp) \
	$(wildcard Presentations/$1/*/*/*.h) \
	$(wildcard Presentations/$1/*/*/*.hpp)
endef

# latexmk сам не отслеживает файлы кода, подключаемые через minted (знает
# только .tex/.sty, которые сам парсит): если какой-либо из исходников
# новее собранного PDF — удаляем PDF, чтобы latexmk пересобрал его,
# иначе latexmk ответит "up to date" и останется stale-PDF.
define generate_pdf
	@for f in $^; do \
		if [ -f "$$f" ] && [ "$$f" -nt $(BUILD_DIR)/$@ ]; then \
			rm -f $(BUILD_DIR)/$@; \
			break; \
		fi; \
	done; \
	TEXINPUTS='$(shell pwd)//:' \
	SOURCE_DATE_EPOCH='$(shell date +%s)' \
	latexmk \
		-lualatex \
		-jobname=$(subst .pdf,,$@) \
		$1
endef

pr-01.pdf: \
	Presentations/01-Intro/intro.tex \
	Presentations/presentationtemplate.sty \
	Presentations/images/binary-file.png \
	Presentations/images/source_code.png \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,01-Intro) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/01-Intro/intro.tex)

pr-02.pdf: \
	Presentations/02-Phases-of-translation/phases_of_translation.tex \
	Presentations/presentationtemplate.sty \
	Presentations/images/binary-file.png \
	Presentations/images/source_code.png \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,02-Phases-of-translation) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/02-Phases-of-translation/phases_of_translation.tex)

pr-03.pdf: \
	Presentations/03-Fundamental-types/fundamental_types.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,03-Fundamental-types) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/03-Fundamental-types/fundamental_types.tex)

pr-04.pdf: \
	Presentations/04-Variables/variables.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,04-Variables) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/04-Variables/variables.tex)

pr-05.pdf: \
	Presentations/05-Selection-statements/selection-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,05-Selection-statements) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/05-Selection-statements/selection-statements.tex)

pr-06.pdf: \
	Presentations/06-Iteration-statements/iteration-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,06-Iteration-statements) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/06-Iteration-statements/iteration-statements.tex)

pr-07.pdf: \
	Presentations/07-Pointers-and-References/ptrs-and-refs.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,07-Pointers-and-References) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/07-Pointers-and-References/ptrs-and-refs.tex)

pr-08.pdf: \
	Presentations/08-Arrays/arrays.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,08-Arrays) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/08-Arrays/arrays.tex)

pr-09.pdf: \
	Presentations/09-Functions/functions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,09-Functions) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/09-Functions/functions.tex)

pr-10.pdf: \
	Presentations/10-Conversions/conversions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,10-Conversions) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/10-Conversions/conversions.tex)

pr-11.pdf: \
	Presentations/11-Structs-and-classes/structs-and-classes.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,11-Structs-and-classes) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/11-Structs-and-classes/structs-and-classes.tex)

pr-12.pdf: \
	Presentations/12-Inheritance/inheritance.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,12-Inheritance) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/12-Inheritance/inheritance.tex)

pr-13.pdf: \
	Presentations/13-Exceptions/exceptions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,13-Exceptions) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/13-Exceptions/exceptions.tex)

pr-14.pdf: \
	Presentations/14-Virtual-members/virtual-members.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,14-Virtual-members) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/14-Virtual-members/virtual-members.tex)

pr-15.pdf: \
	Presentations/15-Templates/templates.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,15-Templates) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/15-Templates/templates.tex)

pr-16.pdf: \
	Presentations/16-Stdlib/stdlib.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,16-Stdlib) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/16-Stdlib/stdlib.tex)

pr-17.pdf: \
	Presentations/17-streams/streams.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,17-streams) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/17-streams/streams.tex)

pr-19.pdf: \
	Presentations/19-algorithms/algorithms.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(call pdf_deps,19-algorithms) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,Presentations/19-algorithms/algorithms.tex)
