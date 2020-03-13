FROM mhart/alpine-node:4

RUN apk add --update-cache \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red

# User data directory, contains flows, config and nodes.
RUN mkdir /data

WORKDIR /usr/src/node-red

# Add node-red user so we aren't running as root.
RUN adduser -h /usr/src/node-red -D -H node-red \
    && chown -R node-red:node-red /data \
        && chown -R node-red:node-red /usr/src/node-red

	USER node-red

	# package.json contains Node-RED NPM module and node dependencies
	COPY package.json /usr/src/node-red/
	RUN npm install

	# User configuration directory volume
	VOLUME ["/data"]
	EXPOSE 1880

	# Environment variable holding file path for flows configuration
	ENV FLOWS=flows.json
	
	#My Custom Packages
	CMD ["npm", "install node-red-contrib-influxdb"]
	CMD ["npm", "install node-red-dashboard"]
	CMD ["npm"," install node-red-contrib-alexa-remote2"] 
	CMD ["npm", "install node-red-contrib-sonos-plus"] 
	CMD ["npm", "install node-red-contrib-tasmota"]
	CMD ["npm", "install node-red-contrib-smartthings"] 
	CMD ["npm", "install node-red-contrib-unifi"]	
	
	#Finally, start node-red
	CMD ["npm", "start", "--", "--userDir", "/data"]
