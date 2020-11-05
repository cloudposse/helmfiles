#!/usr/bin/env bash

function aws_ssm_put() {
    aws ssm put-parameter --type SecureString --key-id "${SSM_KMS_KEY_ALIAS}" --name "$1" --value "$2" --overwrite
}

echo "Waiting for Vault instance to become available..."
until [[ $? == 2 ]]; do
    sleep 5
    VAULT_OUTPUT="$(VAULT_CLIENT_TIMEOUT=5 vault status)"
done

VAULT_RECOVERY_SEAL="$(echo "${VAULT_OUTPUT}" | grep "Recovery Seal Type" | sed -r 's/Recovery Seal Type\s+(\S+)/\1/')"
VAULT_INITIALIZED="$(echo "${VAULT_OUTPUT}" | grep "Initialized" | sed -r 's/Initialized\s+(true|false)/\1/')"
VAULT_SEALED="$(echo "${VAULT_OUTPUT}" | grep "Sealed" | sed -r 's/Sealed\s+(true|false)/\1/')"

if [[ "${VAULT_INITIALIZED}" == "false" ]]; then
    echo "Initializing vault..."
    VAULT_INIT_OUTPUT=$(vault operator init)

    # Collect keys
    VAULT_RECOVERY_KEY1="$(grep 'Recovery Key 1' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Recovery Key 1:\s+(\S+)/\1/')"
    VAULT_RECOVERY_KEY2="$(grep 'Recovery Key 2' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Recovery Key 2:\s+(\S+)/\1/')"
    VAULT_RECOVERY_KEY3="$(grep 'Recovery Key 3' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Recovery Key 3:\s+(\S+)/\1/')"
    VAULT_RECOVERY_KEY4="$(grep 'Recovery Key 4' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Recovery Key 4:\s+(\S+)/\1/')"
    VAULT_RECOVERY_KEY5="$(grep 'Recovery Key 5' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Recovery Key 5:\s+(\S+)/\1/')"

    # Collect token
    VAULT_ROOT_TOKEN="$(grep 'Initial Root Token' <<< ${VAULT_INIT_OUTPUT} | sed -r 's/Initial Root Token:\s+(\S+)/\1/')"

    # Store keys and token in SSM
    aws_ssm_put "/vault/root-token" "$VAULT_ROOT_TOKEN"
    aws_ssm_put "/vault/recovery-key1" "$VAULT_RECOVERY_KEY1"
    aws_ssm_put "/vault/recovery-key2" "$VAULT_RECOVERY_KEY2"
    aws_ssm_put "/vault/recovery-key3" "$VAULT_RECOVERY_KEY3"
    aws_ssm_put "/vault/recovery-key4" "$VAULT_RECOVERY_KEY4"
    aws_ssm_put "/vault/recovery-key5" "$VAULT_RECOVERY_KEY5"
    
    echo "Vault initialization succeeded."
    sleep 10

    # Export our root token so that we can interact with Vault
    export VAULT_TOKEN=${VAULT_ROOT_TOKEN}

    echo "Enabling oidc auth..."
    vault auth enable oidc

    # We could hypothetically handle this configuration in Terraform, although it would require remote access which don't have at this point..
    # So for now, at least, we'll handle it here.
    echo "Configuring policies & OIDC auth..."
    /vault/scripts/configure-auth.sh

    echo "Enabling kv secrets store..."
    vault secrets enable -path=secret kv-v2

    echo "Setting initialization flag in SSM..."
    aws ssm put-parameter --type String --name "/vault/initialized" --value "true" --overwrite
fi
