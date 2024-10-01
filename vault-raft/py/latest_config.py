from boltdb import BoltDB
from raft_types_pb2 import ConfigurationValue

configiration_value = ConfigurationValue()


def main():

    db = BoltDB("../../.env/data/vault.db", readonly=True)
    with db.view() as tx:
        config = tx.bucket(b"config")
        latest_config = config.get(b"latest_config")
        configiration_value.ParseFromString(latest_config)

        for server in configiration_value.servers:
            print(
                "suffrage=%d id='%s' address='%s'"
                % (server.suffrage, server.id, server.address)
            )
        if False:
            with open("../../.env/data/latest_config.bin", "wb") as f:
                f.write(latest_config)


if __name__ == "__main__":
    main()
