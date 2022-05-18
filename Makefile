.DEFAULT_GOAL := help
.SHELL := bash

.PHONY: setup
setup: ## ホスト環境の事前準備
	sudo bash ./scripts/setup-host.sh

.PHONY: docker-build
docker-build: ## Docker イメージのビルド
	docker compose build

.PHONY: launch
launch: ## ビルド済み Docker イメージの実行
	@# localhost による X サーバへの接続の際の認証を無効化
	xhost +local: > /dev/null
	@# 実行
	docker compose run --rm mysql-workbench

.PHONY: icon
icon: ## デスクトップアイコンを作成する (イメージビルド後に実行してください)
	bash ./scripts/make-desktop-icon.sh

.PHONY: shell
shell: ## 実行中の Docker コンテナ内でシェルを実行 (トラブルシューティング用)
	docker compose exec mysql-workbench /bin/bash


# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
