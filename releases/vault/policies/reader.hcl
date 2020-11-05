# List, and read key/value secrets
path "secret/*"
{
  capabilities = ["read", "list"]
}
