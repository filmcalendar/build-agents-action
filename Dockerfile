FROM mhart/alpine-node:16

RUN set -x && \
    apk add --no-cache git bash && \
    git --version && bash --version && node -v && npm -v

WORKDIR /app
COPY package.json /app
RUN npm install --production --no-audit

COPY .bin/fc-agent.cjs /app/.bin/fc-agent.cjs
COPY fc-agents-init.sh /app/
RUN chmod +x /app/.bin/fc-agent.cjs && \
    chmod +x /app/fc-agents-init.sh && \
    npm link && \
    mkdir -p /app/data 
ENV PATH="/app:${PATH}"


ENTRYPOINT [ "fc-agents-init.sh" ]
