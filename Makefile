# If the first argument is "run"...
COMS := run walk
ONE := $(firstword $(MAKECMDGOALS))
go =

ifeq (run,$(ONE)) 
	go = yes
endif
ifeq (walk,$(ONE))
	go = yes
endif

ifdef go
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

prog: 
	echo 111
.PHONY: run
run : prog
	@echo prog $(RUN_ARGS)
	@echo $(MAKECMDGOALS)
.PHONY: walk
walk : prog
	@echo walk $(RUN_ARGS)
	@echo $(MAKECMDGOALS)

