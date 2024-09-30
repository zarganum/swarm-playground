See also: https://developer.hashicorp.com/vault/tutorials/monitoring/inspect-data-boltdb

After putting any `Go` version on system, add `~/go/bin` to the `PATH`.

```sh
go install golang.org/dl/go1.23.1@latest
go1.23.1 mod tidy
```

Protobuf compiler: https://github.com/protocolbuffers/protobuf/releases

Current implementation of ConfigurationValue:
https://github.com/hashicorp/vault/blob/main/physical/raft/types.pb.go
https://github.com/openbao/openbao/blob/main/physical/raft/types.pb.go

