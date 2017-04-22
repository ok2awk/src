# If the first argument is "run"...
ONE := $(firstword $(MAKECMDGOALS))
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

prog: 
	echo 111
run : prog
	echo $(MAKECMDGOALS)
walk : prog
	echo $(MAKECMDGOALS)

love.txt :
	ls > love.txt

