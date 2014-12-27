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
    # Here goes your code
    if (message.type == "binary" && message.on == true)
      turnDeviceOn message.devaddr
    if (message.type == "binary" && message.on == false)
      turnDeviceOff message.devaddr

turnDeviceOn = (id) -> telldus.turnOnSync id
turnDeviceOff = (id) -> telldus.turnOffSync id

socket = new WebSocket "wss://houm.herokuapp.com"
socket.on 'open', onSocketOpen
socket.on 'close', -> exit "Websocket closed"
socket.on 'error', -> exit "Websocket error"
socket.on 'ping', -> socket.pong()
socket.on 'message', onSocketMessage
