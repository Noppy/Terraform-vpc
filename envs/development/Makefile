# <使い方>
# 1. terraformのファイルの整形を行う場合: make
# 2. アカウント作成(OU移動前)のplan確認:  make 
# 4. デプロイ
#     OU移動前まで実行:       make apply_1st
#     OU移動実行:            make apply_2nd
#     一連のデプロイ操作を実行: make apply_all

TERRAFORM := terraform
.DEFAULT_GOAL := fmt

.PHONY: apply
apply_1st: plan validate init fmt-check
	$(TERRAFORM) apply -auto-approve

.PHONY: plan
plan: validate init fmt-check 
	$(TERRAFORM) plan

.PHONY: validatete
validate: init fmt-check
	$(TERRAFORM) validate

.PHONY: init
init: fmt-check
	$(TERRAFORM) init

.PHONY: fmt-check
fmt-check:
	$(TERRAFORM) fmt -recursive -check -diff

.PHONY: fmt
fmt:
	$(TERRAFORM) fmt -recursive -diff
	