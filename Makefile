## http://korea.gnu.org/manual/release/make/make-sjp/make-ko_toc.html
.PHONY : help stop-redis start-redis
.DEFAULT : xxx

LOCAL_REDIS_CONTAINER := redis
RUNNING_REDIS_CONTAINER := $(shell docker ps -f name=$(LOCAL_REDIS_CONTAINER) --format "{{.Names}}")

## https://gist.github.com/prwhite/8168133#gistcomment-3785627
help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

stop-infra: ## Stop redis Docker Container
ifeq ($(RUNNING_REDIS_CONTAINER),$(LOCAL_REDIS_CONTAINER))
	@docker-compose down
else
	@echo "$(LOCAL_REDIS_CONTAINER) is not running."
endif

start-infra: ## Start redis Docker Container
ifneq ($(RUNNING_REDIS_CONTAINER),$(LOCAL_REDIS_CONTAINER))
	@docker-compose up -d
else
	@echo "$(LOCAL_REDIS_CONTAINER) is Already running."
endif