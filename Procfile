dockergen: docker-gen -watch -notify "kill -9 `cat /app/pid`" /app/Caddyfile.tmpl /etc/Caddyfile
caddy: caddy -conf /etc/Caddyfile -log stdout -agree -pidfile /app/pid