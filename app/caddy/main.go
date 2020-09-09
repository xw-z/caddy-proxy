package main

import (
	"github.com/caddyserver/caddy/caddy/caddymain"
	// plug in plugins here, for example:
	// _ "import/path/here"
	_ "github.com/xw-z/caddy-proxy/app/dnsproviders/alidns"
)

func main() {

	caddymain.Run()
}
