#a: {
    foo?: int
    bar?: string
    baz?: string
}

#c: int

#d: bool

b: #a & {
    foo:  3
    baz?: 2  // baz?: _|_
}

x: #a | #c | #d