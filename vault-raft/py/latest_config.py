from boltdb import BoltDB


def main():

    db = BoltDB("../../.env/data/vault.db", readonly=True)
    with db.view() as tx:
        config = tx.bucket(b"config")
        latest_config = config.get(b"latest_config")
        with open("../../.env/data/latest_config.bin", "wb") as f:
            f.write(latest_config)


if __name__ == "__main__":
    main()
