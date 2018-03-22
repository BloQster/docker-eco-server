# docker-eco-game-server
A game server image for ECO.

## Versions:
- ```latest```,```0.7```, ```0.7.2```, ```0.7.2.5```, ```0.7.2.5-beta```

## Usage:
Just create the container and expose the needed ports (cf., below).<br/>
For example: <br/>
```docker run -d --name=eco -p 3000:3000 -p 3001:3001 -v eco_game_server:/bloqster bloqster/docker-eco-game-server:0.7.2.5```

## Ports:
- ```3000``` Game Server Port
- ```3001``` Web Server Port

## Storage:
The config (```/bloqster/config```) and the storage (```/bloqster/storage```) folders are persisted within the volume ```/bloqster```. Thus, you just need to add a volume for ```/bloqster``` and you should be fine.

Have Fun!
Supportlik
