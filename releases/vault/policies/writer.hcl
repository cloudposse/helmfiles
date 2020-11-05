# List, create, and update key/value secrets
path "secret/*"
{
  capabilities = ["create", "update", "list"]
}
