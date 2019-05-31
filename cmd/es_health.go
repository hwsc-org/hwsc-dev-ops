package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
)

var (
	esHealthCmd = &cobra.Command{
		Use:   "health",
		Short: "Test ElasticSearch health status",
		Long:  "Run this command to test health status of ElasticSearch",
		Run: func(c *cobra.Command, args []string) {
			res, err := es7Client.Cat.Health()
			if err != nil {
				fmt.Println(err)
			}
			fmt.Println(res)
		},
	}
)

func init() {
	esCmd.AddCommand(esHealthCmd)
}
