package root

import (
	// imports from a dependency
	"github.com/foo/bar"
	// import from a dependency subdir, rewrite name
	B "github.com/foo/bar/b"
	// import from a nested dir with package name
	"github.com/foo/bar/multi:hello"
	"github.com/foo/bar/multi:world"

	"github.com:common"

	// import from this module
	"github.com/margostino/cuebox/a"
)

root: "root"

vals: {
	ex1: bar.value
	ex2: B.b
	ex3: hello.msg
	ex4: world.msg
	ex5: a.a
}

some_r_def: B.#SomeDef
country: common.#CountryId