FROM alpine:3.6
RUN apk add --no-cache bash git openssh-client

# Github labels
LABEL "com.github.actions.name"="dokku-github-action"
LABEL "com.github.actions.description"="Deploy application to Dokku"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/vitalyliber/dokku-github-action"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="VitalyLiber <zenamax@gmail.com>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]