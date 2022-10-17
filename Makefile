## -----------------------------------------------------------------------------------------------
## This is the Makefile which contains the recipies that define how to interact with the
## repository's YAML files. Is is sort of a habit of mine to create a Makefile.
## 
## ----------------------------------------- Variables -----------------------------------------
## Variables:
## - OS_TYPE: The type of the OS to run the containers for. Either "windows" or "unix". (required)
## 
OS_TYPE = windows
## ----------------------------------------- Commands -----------------------------------------
help:			## Show this help
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

start: check-args		## Run Oracle and SQLDeveloper
	docker compose --env-file conf/$(OS_TYPE).env up -d

stop: check-args	## Stop Oracle and SQLDeveloper
	docker compose --env-file conf/$(OS_TYPE).env down

shell:			## Run a shell in the oracle container
	docker exec -it oracle-db /bin/bash


.DEFAULT:
	@echo Unkown command $@, try make help

## ---------------------------------------------------------------------------------------------
## 
## ----------------------------------------- Guards --------------------------------------------
check-args:		## Check whether OS_TYPE is set correctly
ifndef OS_TYPE
	$(error Please specify the OS_TYPE "windows | unix")
endif
ifeq ($(OS_TYPE), windows)
	@printf "Running the containers in an x-server compatible with Windows...\n"
else ifeq ($(OS_TYPE), unix)
	@printf "Running the containers in an x-server compatible with Unix/Linux...\n"
else
	$(error Invalid OS_TYPE $(OS_TYPE)! Only "windows" and "unix" are allowed)
endif
