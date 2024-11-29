PRIVATE_KEY_HOST_PATH := "$PWD/ansible/id_ed25519"
TERRAFORM_PROD_FOLDER := "$PWD/terraform/production"
KUBE_CONFIG_PATH := "$PWD/kubeconfig"

set positional-arguments
set dotenv-required

set dotenv-load := true

default:
  just --list

alias tf-i := tf-init
tf-init:
	docker run -it -v {{PRIVATE_KEY_HOST_PATH}}:/keys/id_ed25519 -v {{TERRAFORM_PROD_FOLDER}}:/terraform hashicorp/terraform -chdir=/terraform/ init -var "do_token=$DO_API_TOKEN" -var "pvt_key=/keys/id_ed25519"

alias tf-a := tf-apply
tf-apply:
	docker run -it -v {{PRIVATE_KEY_HOST_PATH}}:/keys/id_ed25519 -v {{TERRAFORM_PROD_FOLDER}}:/terraform hashicorp/terraform -chdir=/terraform/ apply -var "do_token=$DO_API_TOKEN" -var "pvt_key=/keys/id_ed25519"

alias tf-d := tf-destroy
tf-destroy:
	docker run -it -v {{PRIVATE_KEY_HOST_PATH}}:/keys/id_ed25519 -v {{TERRAFORM_PROD_FOLDER}}:/terraform hashicorp/terraform -chdir=/terraform/ destroy -var "do_token=$DO_API_TOKEN" -var "pvt_key=/keys/id_ed25519"

alias tf-p := tf-plan
tf-plan:
	docker run -it -v {{PRIVATE_KEY_HOST_PATH}}:/keys/id_ed25519 -v {{TERRAFORM_PROD_FOLDER}}:/terraform hashicorp/terraform -chdir=/terraform/ plan -var "do_token=$DO_API_TOKEN" -var "pvt_key=/keys/id_ed25519"

tf-deploy:
	just tf-init
	just tf-plan
	just tf-apply

kube:
	export KUBECONFIG={{KUBE_CONFIG_PATH}}

all-up:
	docker compose up --build

ansible:
	docker compose --env-file ./.env up ansible --build

sh-ansible:
	docker exec -it ansible bash

k8s-deploy:
	docker exec -it ansible ansible-playbook /playbooks/digitalocean-deployment.yaml

k8s-destroy:
	docker exec -it ansible ansible-playbook /playbooks/digitalocean-destroy.yaml

argocd-pass:
	just kube
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

