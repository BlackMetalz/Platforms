// Check if file contain "nameserver 8.8.8.8", return exit 0, otherwise return code 2
// Remember to build it
package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
)

func IsExist(str, filepath string) bool {

	b, err := ioutil.ReadFile(filepath)
	if err != nil {
		panic(err)
	}

	isExist, err := regexp.Match(str, b)
	if err != nil {
		panic(err)
	}

	return isExist
}

func main() {
	var checkStr, filePath string
	checkStr = "nameserver 8.8.8.8"
	filePath = "/tmp/resolv.conf"

	var result bool = IsExist(checkStr, filePath)

	if result == true {
		fmt.Println("DNS OK")
		os.Exit(0)
	} else {
		fmt.Println("DNS Problem")
		os.Exit(2)
	}

}

