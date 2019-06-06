package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
)

var (
	versionCmd = &cobra.Command{
		Use:   "version",
		Short: "Print the versions of HWSC CLI and ElasticSearch",
		Long:  "Run this command to display versions",
		Run: func(cmd *cobra.Command, args []string) {
			// TODO unit test
			fmt.Println("HWSC CLI: v0.0.0")
			res, err := es7Client.Info()
			if err != nil {
				fmt.Println(err)
			}
			fmt.Println("ElasticSearch version: ", res)
		},
	}
)

func init() {
	rootCmd.AddCommand(versionCmd)
}
