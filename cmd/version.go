package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
)

var (
	versionCmd = &cobra.Command{
		Use:   "version",
		Short: "Print the version number of HWSC service and ElasticSearch",
		Long:  "Run this command to display version number",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("HWSC version: v0.0.0")
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
