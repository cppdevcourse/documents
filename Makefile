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
	pr-15

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
	pr-15

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
	cp "$(BUILD_DIR)/pr-12.pdf" "$(PREFIX)/presentations/12-exceptions.pdf"
	cp "$(BUILD_DIR)/pr-13.pdf" "$(PREFIX)/presentations/13-dynamic-dispatch.pdf"
	cp "$(BUILD_DIR)/pr-14.pdf" "$(PREFIX)/presentations/14-templates.pdf"
	cp "$(BUILD_DIR)/pr-15.pdf" "$(PREFIX)/presentations/15-standard-library.pdf"

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
	@printf "pr-06\tbuild presentation pr-05.pdf\n"
	@printf "pr-07\tbuild presentation pr-07.pdf\n"
	@printf "pr-08\tbuild presentation pr-08.pdf\n"
	@printf "pr-09\tbuild presentation pr-09.pdf\n"
	@printf "pr-10\tbuild presentation pr-10.pdf\n"
	@printf "pr-11\tbuild presentation pr-11.pdf\n"
	@printf "pr-12\tbuild presentation pr-12.pdf\n"
	@printf "pr-13\tbuild presentation pr-13.pdf\n"
	@printf "pr-14\tbuild presentation pr-14.pdf\n"
	@printf "pr-15\tbuild presentation pr-15.pdf\n"

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

define generate_pdf
	TEXINPUTS='$(shell pwd)//:' \
	SOURCE_DATE_EPOCH='$(shell date +%s)' \
	latexmk \
		-lualatex \
		-jobname=$(subst .pdf,,$2) \
		$1
endef

pr-01.pdf: \
	Presentations/01-Intro/intro.tex \
	Presentations/presentationtemplate.sty \
	Presentations/images/binary-file.png \
	Presentations/images/source_code.png \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/01-Intro/*.cpp) \
	$(wildcard Presentations/01-Intro/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-02.pdf: \
	Presentations/02-Phases-of-translation/phases_of_translation.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/02-Phases-of-translation/library/*.cpp) \
	$(wildcard Presentations/02-Phases-of-translation/relocations/*.cpp) \
	$(wildcard Presentations/02-Phases-of-translation/*.cpp) \
	$(wildcard Presentations/02-Phases-of-translation/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-03.pdf: \
	Presentations/03-Fundamental-types/fundamental_types.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/03-Fundamental-types/*.cpp) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-04.pdf: \
	Presentations/04-Variables/variables.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/04-Variables/*.cpp) \
	$(wildcard Presentations/04-Variables/*.h) \
	$(wildcard Presentations/04-Variables/**/*.cpp) \
	$(wildcard Presentations/04-Variables/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-05.pdf: \
	Presentations/05-Selection-statements/selection-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/05-Selection-statements/*.cpp) \
	$(wildcard Presentations/05-Selection-statements/*.h) \
	$(wildcard Presentations/05-Selection-statements/**/*.cpp) \
	$(wildcard Presentations/05-Selection-statements/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-06.pdf: \
	Presentations/06-Iteration-statements/iteration-statements.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/06-Iteration-statements/*.cpp) \
	$(wildcard Presentations/06-Iteration-statements/*.h) \
	$(wildcard Presentations/06-Iteration-statements/**/*.cpp) \
	$(wildcard Presentations/06-Iteration-statements/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-07.pdf: \
	Presentations/07-Pointers-and-References/ptrs-and-refs.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/07-Pointers-and-References/*.cpp) \
	$(wildcard Presentations/07-Pointers-and-References/*.h) \
	$(wildcard Presentations/07-Pointers-and-References/**/*.cpp) \
	$(wildcard Presentations/07-Pointers-and-References/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-08.pdf: \
	Presentations/08-Arrays/arrays.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/08-Arrays/*.cpp) \
	$(wildcard Presentations/08-Arrays/*.h) \
	$(wildcard Presentations/08-Arrays/**/*.cpp) \
	$(wildcard Presentations/08-Arrays/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-09.pdf: \
	Presentations/09-Functions/functions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/09-Functions/*.cpp) \
	$(wildcard Presentations/09-Functions/*.h) \
	$(wildcard Presentations/09-Functions/**/*.cpp) \
	$(wildcard Presentations/09-Functions/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-10.pdf: \
	Presentations/10-Conversions/conversions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	$(wildcard Presentations/10-Conversions/*.cpp) \
	$(wildcard Presentations/10-Conversions/*.h) \
	$(wildcard Presentations/10-Conversions/**/*.cpp) \
	$(wildcard Presentations/10-Conversions/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-11.pdf: \
	Presentations/11-Structs-and-classes/structs-and-classes.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-12.pdf: \
	Presentations/12-Exceptions/exceptions.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-13.pdf: \
	Presentations/13-Virtual-members/virtual-members.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-14.pdf: \
	Presentations/14-Templates/templates.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

pr-15.pdf: \
	Presentations/15-Stdlib/stdlib.tex \
	Presentations/presentationtemplate.sty \
	$(wildcard Presentations/images/*-logo.png) \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)
