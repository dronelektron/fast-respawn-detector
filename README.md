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
* spectatorTime - How long the client was in spectator team (in seconds)

```
forward void OnClientFastRespawned(int client, float spectatorTime);
```

### Usage example

```
#include <sourcemod>

#define FAST_RESPAWN_DETECTOR "fast-respawn-detector"

public Plugin myinfo = {
    name = "Fast respawn notifier",
    author = "Dron-elektron",
    description = "Prints to all players that the client has fast respawned",
    version = "",
    url = ""
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(FAST_RESPAWN_DETECTOR)) {
        SetFailState("Library '%s' is not found", FAST_RESPAWN_DETECTOR);
    }
}

public void OnClientFastRespawned(int client, float spectatorTime) {
    PrintToChatAll("Client %d fast respawned, he was in spectators for %.2f seconds", client, spectatorTime);
}
```
