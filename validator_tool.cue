package root

import (
	"tool/cli"
	"tool/http"
	"tool/file"
	//"encoding/json"
	"encoding/yaml"
	"strings"
)

filepath: *"data.yml" | string @tag(file)
octane:   "https://octane.klarna.net/api/teams/"

command: validate: {
	read: file.Read & {
		filename: filepath
		contents: string
	}

	data:  strings.Replace(strings.Replace(yaml.Marshal(read.contents), "|", "", -1), "---", "", -1)
	teams: yaml.Unmarshal(data)

	for i, team in teams {
		(team.id): http.Get & {
			url: strings.Replace(octane+team.name, " ", "%20", -1)
			response: {
				status:     string
				statusCode: int
				body:       string
			}
		}
		"\(i)": {
			if command.validate["\(team.id)"].response.statusCode != 200 {
				print: cli.Print & {
					text: command.validate["\(team.id)"].url + " - " + command.validate["\(team.id)"].response.status
				}
			}
		}
	}
}