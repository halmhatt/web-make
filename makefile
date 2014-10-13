JSDIR 		= js
JSFILES		= $(wildcard $(JSDIR)/*.js)
SASSDIR		= sass
SASSFILES	= $(wildcard $(SASSDIR)/*.sass)
NPMBINS		= node_modules/.bin
SASSC 		= sass

# Dist directories
DISTDIR		= public
DISTDIR_JS	= $(DISTDIR)/js
DISTDIR_CSS = $(DISTDIR)/css

# Like default, if just run `make`
all: jshint jscs build_js build_css

# Javascript Code Style
jscs: $(JSFILES)
	$(NPMBINS)/jscs $(JSFILES)

# Javascript hint errors
jshint: $(JSFILES)
	$(NPMBINS)/jshint $(JSFILES)

# Sass to css conversion
sass: $(DISTDIR_CSS) $(SASSFILES)
	$(SASSC) -C $(foreach d, , -I$d) --update $(SASSDIR):$(DISTDIR_CSS)


#########
# BUILD #
#########

# Build project
build: build_js build_css

# Build css files
css: build_css
build_css: $(DISTDIR_CSS) sass

# Copy js files
js: build_js
build_js: $(DISTDIR_JS) $(JSFILES)
	cp $(JSFILES) $(DISTDIR_JS)


#####################
# FILE/DIR COMMANDS #
#####################

# Dist directory
$(DISTDIR):
	mkdir $(DISTDIR)

# Javascript dist dir
$(DISTDIR)/js: $(DISTDIR)
	mkdir $(DISTDIR_JS)

# CSS dist dir
$(DISTDIR)/css: $(DISTDIR)
	mkdir $(DISTDIR_CSS)

#########
# CLEAN #
#########

# Clean files in build DIST directory
clean: clean_js clean_css

# Clean js files
clean_js:
	rm -rf $(shell pwd)/$(DISTDIR)/js/*

# Clean css files
clean_css:
	rm -rf $(shell pwd)/$(DISTDIR)/css/*

# Does not produce new files
.PHONY: all jscs jshint sass all build js build_js css build_css clean clean_js clean_css
