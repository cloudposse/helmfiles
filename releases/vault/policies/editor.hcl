# List, create, read, and update key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "list"]
}
