FROM nodered/node-red
RUN npm install node-red-contrib-influxdb  && npm install node-red-dashboard && npm install node-red-contrib-alexa-remote2 && npm install node-red-contrib-sonos-plus && npm install node-red-contrib-tasmota && npm install node-red-contrib-smartthings && npm install node-red-contrib-unifi && npm install node-red-contrib-syslog-input

