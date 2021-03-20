          DIRTY := $(shell  if [ $$(git status --porcelain | wc -l) -gt 0 ] ; then echo "-dirty"; fi)
      SHORT_SHA := $(shell git rev-parse --short HEAD)$(DIRTY)

# Cute hack thanks to:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Display this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dev-clean: ## Cleanup the deployment and rendered templates. 
	kubectl delete -f rendered/papercups/templates/; rm -rf rendered

dev-template: dev-clean ## Render the templates with the default values.
	helm template papercups ./ --output-dir rendered/

dev-deploy: dev-template ## Deploy the rendered templates with the default values.
	kubectl create -f rendered/papercups/templates/


.PHONY: help dev-deploy dev-template dev-clean help