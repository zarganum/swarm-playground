ui = false

api_addr  = "http://vault-{{.Task.Slot}}:8200"
cluster_addr  = "https://vault-{{.Task.Slot}}:8201"

storage "raft" {
  path    = "/data"

  retry_join {
      leader_api_addr = "http://vault-1:8200"
    }
  retry_join {
      leader_api_addr = "http://vault-2:8200"
    }
  retry_join {
      leader_api_addr = "http://vault-3:8200"
    }

}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}
