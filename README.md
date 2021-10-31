
**Support**

If you require any form of support after acquiring this resource, the right place to ask is our 
Discord Server: https://discord.gg/UyAu2jABzE

Make sure to react to the initial message with the tick and your language to get access to all 
the different channels.

Please do not contact anyone directly unless you have a really specific request that does not 
have a place in the server.


## What does it do exactly?

This is a small resource that allows players to trip when walking over a rake. This was originally 
planned as a "banana peel ragdoll"-thingy. But I didn't want to stream additional objects. And I 
found a rake and thought that could work :D
This will work with any rake on the server. Not just spawned ones.
For ESX you can use an item and if you don't use ESX, there is an export included that allows to 
spawn a rake. (see Installation instructions / Export usage)

Showcase video: https://www.youtube.com/watch?v=yZrYLUXH7-k


### Requirements

- OneSync
- (optional) ESX (any version)


## Features

- Players can place rakes on the ground.
- Players will ragdoll when walking/running over the rake.
- export for spawning rakes if not using ESX
- Rake item for spawning

## Planned Features

- Probably more objects.
- More config options.


### Performance

- Client Side: idle 0.01ms, in use up to 0.03ms


### Installation instructions

1. Extract the downloaded folder into your resources.
2. Start the resource in your server.cfg:
3. (ESX only) Create an item with name "rake" in your database.
```
start TripOnRake
```


### Export usage

You can simply call
```
exports["TripOnRake"]:SpawnRake()
```
from a client side script to create a rake at the current players location.


### Patchnotes
