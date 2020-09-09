package alidns

import (
	"errors"

	"github.com/caddyserver/caddy/caddytls"
	"github.com/go-acme/lego/v3/providers/dns/alidns"
)

func init() {
	caddytls.RegisterDNSProvider("alidns", NewDNSProvider)
}

// NewDNSProvider returns a new GoDaddy DNS challenge provider.
// The credentials are interpreted as follows:
//
// len=0: use credentials from environment
// len=3: credentials[0] = API key
//         credentials[1] = API secret
//         credentials[2] = API region id

func NewDNSProvider(credentials ...string) (caddytls.ChallengeProvider, error) {
	switch len(credentials) {
	case 0:
		return alidns.NewDNSProvider()
	case 3:
		config := alidns.NewDefaultConfig()
		config.APIKey = credentials[0]
		config.SecretKey = credentials[1]
		config.RegionID = credentials[2]
		return alidns.NewDNSProviderConfig(config)
	default:
		return nil, errors.New("invalid credentials length")
	}
}
