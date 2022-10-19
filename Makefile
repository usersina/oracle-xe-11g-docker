## -----------------------------------------------------------------------------------------------
## This is the Makefile which contains the recipies that define how to interact with the
## repository's YAML files. Is is sort of a habit of mine to create a Makefile.
## 
## ----------------------------------------- Variables -----------------------------------------
## Computed Variables: These are automatically set
## - CV_OSTYPE: The type of the OS to run the containers for. Either "windows" or "unix".
## 
CV_OSTYPE = $(shell ./conf/get_os.sh)
## ----------------------------------------- Commands -----------------------------------------
help:			## Show this help
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

start: set_os		## Run Oracle and SQLDeveloper
	docker compose --env-file conf/$(CV_OSTYPE).env up -d

stop: set_os		## Stop Oracle and SQLDeveloper
	docker compose --env-file conf/$(CV_OSTYPE).env stop

delete: set_os		## Stop and remove containers and networks
	docker compose --env-file conf/$(CV_OSTYPE).env down

shell:			## Run a shell in the oracle container
	docker exec -it oracle-db /bin/bash

.DEFAULT:
	@echo Unkown command $@, try make help

## ---------------------------------------------------------------------------------------------
## 
## ----------------------------------------- Guards --------------------------------------------
set_os:		## Check whether OS_TYPE is set correctlys
ifeq ($(CV_OSTYPE), windows)
	@printf "Running the containers in an x-server compatible with Windows...\n"
else ifeq ($(CV_OSTYPE), unix)
	@printf "Running the containers in an x-server compatible with Unix/Linux...\n"
else
	$(error Invalid OSTYPE "$(CV_OSTYPE)"! Only "windows" and "unix" are allowed)
endif
