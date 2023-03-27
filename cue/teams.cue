package common

import (
	//"github.com/margostino/cuebox:common"
	"github.com/margostino/cuebox/common"
)

//other: thing: common.#TeamId

#Team: {
	id: common.#TeamId
	name: string
	email: string
}

[...#Team]



//[{
//	id: "auth"
//	name: "Authentication"
//	email: "auth@some.com"
//},...]
