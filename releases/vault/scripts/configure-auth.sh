function group_id() {
    echo "${GROUP_DATA}" | jq -r '."data"."id"'
}

# Define our OIDC role policies
OIDC_ROLE_POLICIES=( 
    "noaccess"
    "reader"
    "writer"
    "editor"
    "manager"
    "admin"
)

# Create policies
for i in ${OIDC_ROLE_POLICIES[@]}; do
    vault policy write $i /vault/policies/$i.hcl
done

# Configure OIDC Authentication
vault write auth/oidc/config \
        oidc_discovery_url="${OIDC_DISCOVERY_URL}" \
        oidc_client_id="${VAULT_OIDC_CLIENT_ID}" \
        oidc_client_secret="${VAULT_OIDC_CLIENT_SECRET}" \
        default_role="noaccess"

# Create the roles
for t in ${OIDC_ROLE_POLICIES[@]}; do
    vault write auth/oidc/role/${t} \
            bound_audiences="${VAULT_OIDC_CLIENT_ID}" \
            allowed_redirect_uris="${ALLOWED_REDIRECT_URIS1}" \
            allowed_redirect_uris="${ALLOWED_REDIRECT_URIS2}" \
            user_claim="sub" \
            policies="${t}" \
            groups_claim="groups" \
            oidc_scopes="groups"
done

# Get the mount accessor value of the oidc auth method and save it in accessor.txt file
VAULT_OIDC_ACCESSOR="$(vault auth list -format=json  | jq -r '."oidc/".accessor')"

GROUP_DATA="$(vault write -format=json identity/group name="noaccess" type="external" policies="noaccess" metadata=responsibility="No Access K/V Secrets")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-noaccess" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"

GROUP_DATA="$(vault write -format=json identity/group name="reader" type="external" policies="reader" metadata=responsibility="Reader K/V Secrets")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-reader" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"

GROUP_DATA="$(vault write -format=json identity/group name="writer" type="external" policies="writer" metadata=responsibility="Writer K/V Secrets")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-writer" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"

GROUP_DATA="$(vault write -format=json identity/group name="editor" type="external" policies="manager" metadata=responsibility="Editor K/V Secrets")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-editor" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"

GROUP_DATA="$(vault write -format=json identity/group name="manager" type="external" policies="manager" metadata=responsibility="Manage K/V Secrets")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-manager" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"

GROUP_DATA="$(vault write -format=json identity/group name="admin" type="external" policies="admin" metadata=responsibility="Admin Vault")"
vault write identity/group-alias name="${VAULT_STAGE}-vault-admin" \
        mount_accessor="${VAULT_OIDC_ACCESSOR}" \
        canonical_id="$(group_id)"
