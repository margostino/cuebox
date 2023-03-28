package root

import (
	"tool/cli"
	//"tool/exec"
	"tool/http"
	"tool/file"
	//"encoding/json"
	//"encoding/yaml"
)

// moved to the data.cue file to show how we can reference "pure" Cue files
// city: "Amsterdam"

team: *"some" | string @tag(team)

// A command named "prompter"
command: validate: {

	// save transcript to this file
	//	var: {
	//		file: *"out.txt" | string @tag(file)
	//	} // you can use "-t flag=filename.txt" to change the output file, see "cue help injection" for more details

	// prompt the user for some input
	//	ask: cli.Ask & {
	//		prompt:   "What is your name?"
	//		response: string
	//	}

	// run an external command, starts after ask
	//	echo: exec.Run & {
	//		// note the reference to ask and city here
	//		cmd: ["echo", "Hello", ask.response + "!", "Have you been to", city + "?"]
	//		stdout: string // capture stdout, don't print to the terminal
	//	}

	list: file.Glob & {
		glob: "data/teams.yaml"
	}

	// comprehend tasks for each file, also an inferred dependency
	//	for _, filepath in list.files {
	//		// make a unique key for the tasks per item
	//		(filepath): {
	//			// and have locally referenced dependencies
	//			read: file.Read & {
	//				filename: filepath
	//				contents: string
	//			}
	//			for _, team in yaml.Unmarshal(read.contents) {
	//				(team.name): {
	//					print: cli.Print & {
	//						text: team.name // an inferred dependency
	//					}
	//				}
	//			}
	//		}
	//	}

	info: http.Get & {
		url: "http://localhost:10000/teams/" + team
		response: {
			status:     string
			statusCode: int
			body:       string
		}
	}

	// append to a file, starts after echo
	//	append: file.Append & {
	//		filename: var.file
	//		contents: echo.stdout // because we reference the echo task
	//	}

	// also starts after echo, and concurrently with append

	print: cli.Print & {
		//text: echo.stdout // write the output to the terminal since we captured it previously
		text: info.url + " - " + info.response.status
//		if info.response.statusCode = 200 {
//			text: json.Unmarshal(info.response.body).team
//		}

	}

}
