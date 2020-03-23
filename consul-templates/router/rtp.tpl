id(int,auto) setid(int) url(string) weight(int) disabled(int) stamp(int)
{{range $index, $service := service "rtp"}}{{ add $index 1 }}:0:udp\:{{.Address}}\:{{.Port}}:1:0:0
{{end}}
