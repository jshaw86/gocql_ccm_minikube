package main

import (
	"fmt"
	"github.com/gocql/gocql"
	"os"
	"strconv"
)

func main() {
	cassandraEndpoints := []string{os.Getenv("CASSANDRA")}
	keyspace := os.Getenv("KEYSPACE")
	protoVersion, _ := strconv.Atoi(os.Getenv("PROTO_VERSION"))
	cqlVersion := os.Getenv("CQL_VERSION")
	query := os.Getenv("QUERY")

	cluster := gocql.NewCluster(cassandraEndpoints...)
	cluster.Keyspace = keyspace
	cluster.ProtoVersion = protoVersion
	cluster.CQLVersion = cqlVersion
	session, err := cluster.CreateSession()

	if err == nil {
		result, _ := session.Query(query).Iter().SliceMap()
		fmt.Printf("Result %s", result)
	} else {
		fmt.Printf("Session %s", err)

	}
}
