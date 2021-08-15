FROM debian:buster-slim

# Github labels
LABEL "com.github.actions.name"="dokku-github-action"
LABEL "com.github.actions.description"="Deploy application to Dokku (Fork)"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/eventyret/dokku-github-action"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Simen Daehlin <simen.dehlin@gmail.com>"

RUN apt-get update && apt-get install -y \
  openssh-client \
  git && \
  rm -Rf /var/lib/apt/lists/*


ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]