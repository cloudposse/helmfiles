#!/bin/bash

LABEL_NAME=cert-manager-version
QUOTED_LABEL_NAME="${LABEL_NAME//\./\\.}"

function usage() {
	echo $(basename "$0") 'upgrade <version>'
	echo $(basename "$0") 'uninstall'
	echo
	echo 'upgrade <version>'
	echo '  Installs or updates cert-manager CRDs to the given chart version'
	echo
	echo 'uninstall <version>'
	echo '  Uninstalls (deletes) the cert-manager CRDs that would have been installed by given chart version'
	echo
}

function upgrade() {
	local version="$1"
	local currentVersion

	if [[ -z $version ]]; then
		echo Chart Version must be specified >&2
		return 1
	fi

	currentVersion=$(kubectl get crds certificates.cert-manager.io -o=jsonpath="{.metadata.labels.${QUOTED_LABEL_NAME}}" 2>/dev/null)
	if [[ $currentVersion == $version ]]; then
		echo "cert-manager CRDs appear up-to-date, no action taken"
	else
		echo "Updating cert-manager CRDs to ${version}"
		kubectl apply --validate=false -f "https://github.com/jetstack/cert-manager/releases/download/${version}/cert-manager.crds.yaml" &&
			kubectl label --overwrite crds certificates.cert-manager.io "${LABEL_NAME}=${version}"
	fi
}

function uninstall() {
	local version="$1"

	if [[ -z $version ]]; then
		echo Chart Version must be specified >&2
		return 1
	fi

	echo kubectl delete -f "https://github.com/jetstack/cert-manager/releases/download/${version}/cert-manager.crds.yaml"
	kubectl delete -f "https://github.com/jetstack/cert-manager/releases/download/${version}/cert-manager.crds.yaml"
}

main() {
	local command="$1"
	shift

	case $command in
	upgrade)
		upgrade "$@"
		;;
	uninstall)
		uninstall "$@"
		;;
	*)
		usage
		;;
	esac
}

main "$@"
