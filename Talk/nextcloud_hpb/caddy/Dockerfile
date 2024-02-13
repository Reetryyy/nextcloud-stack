FROM caddy:2.7.6

# Install curl
RUN apk add --no-cache curl

# Coppy files
COPY Caddyfile /etc/caddy/Caddyfile
COPY --chmod=775 healthcheck.sh /healthcheck.sh

# ENV
ENV HPB_DOMAIN=""

# Expose
EXPOSE 80
EXPOSE 443

# Command to run
HEALTHCHECK CMD ["sh", "/healthcheck.sh"]
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
