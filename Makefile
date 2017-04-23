.PHONY: all dirs gawk4 files make1 run gitready hi bye

Etc=_etc
Config=$(HOME)/.config/ok/config

##############################################
# stuff to load defaults, then maybe override
# them (if $(Config) exists)

include $(Etc)/config.default
-include $(Config)

#############################################
# stuff to make runtime files AND dirs

ready:  gawk4 dirs files

#############################################
# stuff to make runtime dirs

dirs:
	@mkdir -p $(Awk)
	@mkdir -p $(Lib)
	@mkdir -p $(Tmp)
	@mkdir -p $(Docs)

#############################################
# stuff to check if our awk is good
# crashes if awk != gawk verion 4.1 or later

gawk4: 
	@awk 'BEGIN {if (PROCINFO["version"] !~ /4.1.*/) exit 1}'

#############################################
# stuff to make runtime files

.gitignore : $(Etc)/gitignore
	cp $<  $@

files: .gitignore
	@$(foreach d,$(shell find [a-z]*/* -type d -maxdepth 2),\
		mkdir -p $(Awk)/$d;\
		$(MAKE) -s D=$d $(Awk)/$d/run;\
		$(foreach f, $(wildcard $d/*.ok), \
			$(MAKE) -s D=$d F=$f G=$(f:.ok=.awk) make1;))

make1: $(Awk)/$G 

$(Awk)/$D/run : $D/run
	echo "# $< ==> $@"
	echo "#!/usr/bin/env bash" > $@
	sed 's?XXX?$(Awk)?g' $< >> $@
	chmod +x $@

$(Awk)/$G : $F
	echo "# $< ==> $@"
	awk -f $(Etc)/ok2awk.awk $< > $@	

###########################################
# run-ning stuff
# assumes called via the 'run' shell script

run:  
	@$(Awk)/$(Pkg)/run $(Main).awk $(Args)

###########################################
# git stuff
#
gitting:
	@git config --global user.email "$(MyEmail)"
	@git config --global user.name  "$(MyName)"
	@git config --global credential.helper cache
	@git config credential.helper 'cache --timeout=3600'

hi: gitting
	@git pull origin master

bye: gitting
	@git add .
	@git commit -am newStuff
	@git push origin master
