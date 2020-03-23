id(int) domain(string) did(string) last_modified(int)
{{range $index, $service := service "router"}}{{ add $index 1 }}:{{.Address}}:{{.Address}}:0
{{end}}
