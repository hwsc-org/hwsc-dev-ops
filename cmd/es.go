package cmd

import (
	"crypto/tls"
	"fmt"
	es7 "github.com/elastic/go-elasticsearch/v7"
	"github.com/spf13/cobra"
	"net"
	"net/http"
	"time"
)

var (
	cfg = es7.Config{
		// TODO: move these environment variables
		Addresses: []string{
			"http://localhost:9200",
			"http://localhost:9201",
		},
		Username: "foo",
		Password: "bar",
		Transport: &http.Transport{
			MaxIdleConnsPerHost:   10,
			ResponseHeaderTimeout: time.Second,
			DialContext:           (&net.Dialer{Timeout: time.Second}).DialContext,
			TLSClientConfig: &tls.Config{
				MinVersion: tls.VersionTLS11,
			},
		},
	}
	es7Client *es7.Client
	esCmd     = &cobra.Command{
		Use:   "es",
		Short: "ElasticSearch command line tool",
		Long:  "Combine this command with a sub command",
		Run:   func(cmd *cobra.Command, args []string) {},
	}
)

func init() {
	var err error
	es7Client, err = es7.NewClient(cfg)
	if err != nil {
		fmt.Println(err)
	}
	rootCmd.AddCommand(esCmd)
}
