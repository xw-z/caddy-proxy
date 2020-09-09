dockergen: docker-gen -watch -notify "pkill -USR1 caddy" /app/Caddyfile.tmpl /etc/Caddyfile
caddy: caddy -conf /etc/Caddyfile -log stdout -agree