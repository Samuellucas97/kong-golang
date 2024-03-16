all: run
.PHONY: all clean

run: clean
	@echo
	docker version -f json
	@echo
	@echo
	docker compose version
	@echo
	@echo "***************** RUNNING DOCKER COMPOSE AT ${CURRENT_PATH} *****************"
	@echo
	KONG_DATABASE=postgres docker compose up -d
	@echo
	@echo
	docker ps
	@echo
  
  


clean:
	@echo
	@echo
	docker compose down --volumes
	@echo
	@echo
	docker ps
	@echo