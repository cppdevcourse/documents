ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR := build

.PHONY: \
	all \
	build \
	clean \
	help \
	hw-01 \
	hw-02 \
	hw-03 \
	hw-04 \
	hw-05 \
	hw-06 \
	hw-07 \
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
	prj-auth-lib \
	prj-enc-exch

all: build

build: \
	hw-01 \
	hw-02 \
	hw-03 \
	hw-04 \
	hw-05 \
	hw-06 \
	hw-07 \
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
	prj-auth-lib \
	prj-enc-exch

install: build
	mkdir -p "$(PREFIX)/Презентации"
	cp "$(BUILD_DIR)/pr-01.pdf" "$(PREFIX)/Презентации/01 Введение.pdf"
	cp "$(BUILD_DIR)/pr-02.pdf" "$(PREFIX)/Презентации/02 Фазы трансляции.pdf"
	cp "$(BUILD_DIR)/pr-03.pdf" "$(PREFIX)/Презентации/03 Фундаментальные типы.pdf"
	cp "$(BUILD_DIR)/pr-04.pdf" "$(PREFIX)/Презентации/04 Переменные.pdf"
	cp "$(BUILD_DIR)/pr-05.pdf" "$(PREFIX)/Презентации/05 Условия.pdf"
	cp "$(BUILD_DIR)/pr-06.pdf" "$(PREFIX)/Презентации/06 Циклы.pdf"
	cp "$(BUILD_DIR)/pr-07.pdf" "$(PREFIX)/Презентации/07 Указатели и ссылки.pdf"
	cp "$(BUILD_DIR)/pr-08.pdf" "$(PREFIX)/Презентации/08 Массивы.pdf"
	cp "$(BUILD_DIR)/pr-09.pdf" "$(PREFIX)/Презентации/09 Функции.pdf"
	cp "$(BUILD_DIR)/pr-10.pdf" "$(PREFIX)/Презентации/10 Приведения типов.pdf"
	cp "$(BUILD_DIR)/pr-11.pdf" "$(PREFIX)/Презентации/11 Структуры и классы.pdf"
	cp "$(BUILD_DIR)/pr-12.pdf" "$(PREFIX)/Презентации/12 Исключения.pdf"
	cp "$(BUILD_DIR)/pr-13.pdf" "$(PREFIX)/Презентации/13 Виртуальные методы и полиморфизм.pdf"
	cp "$(BUILD_DIR)/pr-14.pdf" "$(PREFIX)/Презентации/14 Шаблоны.pdf"
	cp "$(BUILD_DIR)/pr-15.pdf" "$(PREFIX)/Презентации/15 Стандартная библиотека.pdf"
	mkdir -p "$(PREFIX)/Домашние задания"
	cp "$(BUILD_DIR)/hw-01.pdf" "$(PREFIX)/Домашние задания/01 Hello World.pdf"
	cp "$(BUILD_DIR)/hw-02.pdf" "$(PREFIX)/Домашние задания/02 Git & Github.pdf"
	cp "$(BUILD_DIR)/hw-03.pdf" "$(PREFIX)/Домашние задания/03 Two Sum.pdf"
	cp "$(BUILD_DIR)/hw-04.pdf" "$(PREFIX)/Домашние задания/04 The Guessing Game.pdf"
	cp "$(BUILD_DIR)/hw-05.pdf" "$(PREFIX)/Домашние задания/05 Hide Secret.pdf"
	cp "$(BUILD_DIR)/hw-06.pdf" "$(PREFIX)/Домашние задания/06 LIFO Stack.pdf"
	cp "$(BUILD_DIR)/hw-07.pdf" "$(PREFIX)/Домашние задания/07 Real48.pdf"
	mkdir -p "$(PREFIX)/Проекты"
	cp "$(BUILD_DIR)/prj-auth-lib.pdf" "$(PREFIX)/Проекты/Библиотека идентификации и аутентификации.pdf"
	cp "$(BUILD_DIR)/prj-enc-exch.pdf" "$(PREFIX)/Проекты/Baremetal шифрование обмена.pdf"

clean:
	rm -rf $(BUILD_DIR)

help:
	@printf "all\tbuild all presentations and homeworks\n"
	@printf "build\tbuild all presentations and homeworks\n"
	@printf "clean\tremove build artifacts\n"
	@printf "help\tprint this message\n"
	@printf "hw-01\tbuild homework hw-01.pdf\n"
	@printf "hw-02\tbuild homework hw-02.pdf\n"
	@printf "hw-03\tbuild homework hw-03.pdf\n"
	@printf "hw-04\tbuild homework hw-04.pdf\n"
	@printf "hw-05\tbuild homework hw-05.pdf\n"
	@printf "hw-06\tbuild homework hw-06.pdf\n"
	@printf "hw-07\tbuild homework hw-07.pdf\n"
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
	@printf "prj-auth-lib\tbuild project prj-auth-lib.pdf\n"
	@printf "prj-enc-exch\tbuild project prj-enc-exch.pdf\n"

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

hw-01: hw-01.pdf
hw-02: hw-02.pdf
hw-03: hw-03.pdf
hw-04: hw-04.pdf
hw-05: hw-05.pdf
hw-06: hw-06.pdf
hw-07: hw-07.pdf

prj-auth-lib: prj-auth-lib.pdf
prj-enc-exch: prj-enc-exch.pdf

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

hw-01.pdf: \
	Homeworks/01-Hello-World/hello_world.tex \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/01-Hello-World/*.cpp) \
	$(wildcard Homeworks/01-Hello-World/*.txt) \
	$(wildcard Homeworks/01-Hello-World/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-02.pdf: \
	Homeworks/02-Git/git.tex \
	Homeworks/homeworktemplate.sty \
	$(wildcard Homeworks/02-Git/**/*.cpp) \
	$(wildcard Homeworks/02-Git/**/*.h) \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-03.pdf: \
	Homeworks/03-TwoSum/two-sum.tex \
	Homeworks/homeworktemplate.sty \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-04.pdf: \
	Homeworks/04-Guessing-Game/guessing-game.tex \
	Homeworks/homeworktemplate.sty \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-05.pdf: \
	Homeworks/05-Hide-Secret/hide-secret.tex \
	Homeworks/homeworktemplate.sty \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-06.pdf: \
	Homeworks/06-LIFO-Stack/lifo-stack.tex \
	Homeworks/homeworktemplate.sty \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

hw-07.pdf: \
	Homeworks/07-Real48/real48.tex \
	Homeworks/homeworktemplate.sty \
	Packages/terminal.sty \
	Packages/mylisting.sty
	$(call generate_pdf,$<,$@)

prj-auth-lib.pdf: \
	Projects/Identification-and-Authentication-Library/auth-library.tex \
	$(wildcard Projects/images/*.jpg) \
	Packages/mylisting.sty \
	Projects/projectstemplate.sty
	$(call generate_pdf,$<,$@)
	
prj-enc-exch.pdf: \
	Projects/Baremetal-exchange-encryption/exchange-encryption.tex \
	$(wildcard Projects/images/*.jpg) \
	Packages/mylisting.sty \
	Projects/projectstemplate.sty
	$(call generate_pdf,$<,$@)
