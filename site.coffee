WebSocket = require('ws')
telldus = require('telldus')

exit = (msg) ->
  console.log msg
  process.exit 1

sitekey = process.env.HORSELIGHTS_SITEKEY || exit "HORSELIGHTS_SITEKEY not defined"

onSocketOpen = ->
  console.log "Connected to wss://houm.herokuapp.com"
  pingId = setInterval ( -> socket.ping(null, {}, false) ), 3000
  publish = JSON.stringify { command: "publish", data: { sitekey: sitekey, vendor: "nexa" } }
  socket.send(publish)
  console.log "Sent message:", publish

onSocketMessage = (s) ->
  try
    message = JSON.parse s
    console.log "Received message: %j", message
    if (message.data.type == "binary" && message.data.on == true)
      turnDeviceOn (Number) message.data.devaddr
    if (message.data.type == "binary" && message.data.on == false)
      turnDeviceOff (Number) message.data.devaddr
    if (message.data.type == "dimmable")
      dimDevice (Number) message.data.devaddr, (Number) message.data.bri

turnDeviceOn = (id) ->
  console.log "Turning on id: %s", id
  telldus.turnOnSync id
turnDeviceOff = (id) ->
  console.log "Turning off id: %s", id
  telldus.turnOffSync id
dimDevice = (id, bri) ->
  console.log "Dimming id: %s to %s", id, bri
  if (bri == 0)
    telldus.turnOffSync id
  else
    telldus.dimSync id, bri

socket = new WebSocket "wss://houm.herokuapp.com"
socket.on 'open', onSocketOpen
socket.on 'close', -> exit "Websocket closed"
socket.on 'error', -> exit "Websocket error"
socket.on 'ping', -> socket.pong()
socket.on 'message', onSocketMessage
