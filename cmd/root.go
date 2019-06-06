package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
)

var rootCmd = &cobra.Command{
	Use:   "hwsc-cli",
	Short: "Humpback Whale Social Call command line tool",
	Long:  "For more information, select the following available commands",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("For more information on a specific command, type help command-name")
	},
}

// Execute should be run on the root for clarity,
// though it can be called on any command
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
