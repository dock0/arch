package main

import (
	"os"
)

func main() {
	os.Chmod("/.ducktape", 0755)
}
