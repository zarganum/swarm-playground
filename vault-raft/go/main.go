package main

import (
	"fmt"
	"log"

	bbolt "go.etcd.io/bbolt"
)

func main() {
    // Open the database
    db, err := bbolt.Open("../../.env/data/vault.db", 0600, &bbolt.Options{ReadOnly: true})
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

err = db.View(func(tx *bbolt.Tx) error {
        // Get the "config" bucket
        bucket := tx.Bucket([]byte("config"))
        if bucket == nil {
            return fmt.Errorf("bucket 'config' not found")
        }

        // Get the value for the "latest_config" key
        value := bucket.Get([]byte("latest_config"))
        if value == nil {
            return fmt.Errorf("key 'latest_config' not found")
        }

        // Print the value
        fmt.Printf("Value for 'latest_config': %s\n", value)
        return nil
    })
    if err != nil {
        log.Fatal(err)
    }
}
