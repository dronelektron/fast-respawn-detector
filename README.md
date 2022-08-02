# Fast respawn detector

Allows you to detect a fast respawn:

* When a player dies, changes class next to spawn zone
* When a player dies, joins the spectator team for a while and then returns to the game

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/fast-respawn-detector/releases) (compiled for SourceMod 1.11)
* Extract "plugins" folder to "addons/sourcemod" folder of your server

### API

* client - Client's number
* spectatorsTime - How long the client was in spectators (in seconds)

```
forward void OnClientFastRespawned(int client, float spectatorsTime);
```

### Usage example

```
#include <sourcemod>

#define FAST_RESPAWN_DETECTOR_LIBRARY "fast-respawn-detector"

public Plugin myinfo = {
    name = "Fast respawn detector (checker)",
    author = "Dron-elektron",
    description = "Test plugin",
    version = "",
    url = ""
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(FAST_RESPAWN_DETECTOR_LIBRARY)) {
        SetFailState("Library '%s' is not found", FAST_RESPAWN_DETECTOR_LIBRARY);
    }
}

public void OnClientFastRespawned(int client, float spectatorsTime) {
    PrintToChatAll("Client %d fast respawned, he was in spectators %.2f seconds", client, spectatorsTime);
}
```
