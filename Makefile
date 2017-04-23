Cmd := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(Cmd):;@:)

Etc=_etc
Config=$(HOME)/.config/ok/config

include $(Etc)/config.default
-include $(Config)

.PHONY: all dirs gawk4 files make1 run

ready:  dirs gawk4 files

dirs:
	@mkdir -p $(Awk)
	@mkdir -p $(Lib)
	@mkdir -p $(Tmp)
	@mkdir -p $(Docs)

gawk4: # crashes if awk != gawk verion 4.1 or later
	@awk 'BEGIN {if (PROCINFO["version"] !~ /4.1.*/) exit 1}'

.gitignore : $(Etc)/gitignore
	cp $<  $@

files: .gitignore
	@$(foreach d,$(shell find [a-z]*/* -type d -maxdepth 2),\
		mkdir -p $(Awk)/$d;\
		$(foreach f, $(wildcard $d/*.ok), \
			$(MAKE)   D=$d F=$f G=$(f:.ok=.awk) make1;))

### run has to add the path
make1: $(Awk)/$G $(Awk)/run
	

$(Awk)/run : $D/run
	echo "#!/usr/bin/env bash" > $@
	sed 's?XXX?$(Awk)?' $< >> $@
	chmod +x $@

$(Awk)/$G : $F
	echo "# $F ==> $(Awk)/$G"
	awk -f $(Etc)/ok2awk.awk $< > $@	

run:  ready
	$(Awk)/$(dir $(Cmd))run $(notdir $(Cmd))
	@if [ -f "awkvars.out" ]; then\
	       	awk '/[A-Z][A-Z]/ {next} {print "W> rogue local: " $0}' awkvars.out;\
		rm awkvars.out;\
	fi

