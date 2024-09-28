ui = false

api_addr  = "http://vault-{{.Task.Slot}}:8200"

storage "raft" {
  node_id = "raft_node_{{.Task.Slot}}"
  path    = "/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}
