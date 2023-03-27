package main

import (
	"cuelang.org/go/cue"
	"cuelang.org/go/encoding/gocode"
	"io/ioutil"
)

const config = `
msg:   "Hello \(place)!"
place: string | *"world" // "world" is the default.
`

var r cue.Runtime

func main() {
	instance, _ := r.Compile("test", config)

	str, _ := instance.Lookup("msg").String()
	println(str)

	b, err := gocode.Generate("github.com/margostino/cuebox", instance, nil)
	if err != nil {
		// handle error
		println(err.Error())
	}

	err = ioutil.WriteFile("cue_gen.go", b, 0644)
}
