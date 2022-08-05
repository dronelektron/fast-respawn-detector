#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#include "frd/client"
#include "frd/use-case"

#include "modules/api.sp"
#include "modules/client.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Fast respawn detector",
    author = "Dron-elektron",
    description = "Allows you to detect a fast respawn",
    version = "1.0.2",
    url = "https://github.com/dronelektron/fast-respawn-detector"
};

public void OnPluginStart() {
	Api_Create();
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("player_spawn", Event_PlayerSpawn);
	HookEvent("player_team", Event_PlayerTeam);
	HookEvent("player_changeclass", Event_PlayerChangeClass);
}

public void OnPluginEnd() {
	Api_Destroy();
}

public APLRes AskPluginLoad2(Handle plugin, bool late, char[] error, int errMax) {
    RegPluginLibrary("fast-respawn-detector");

    return APLRes_Success;
}

public void OnClientConnected(int client) {
	Client_Reset(client);
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    Client_SetKilled(client, KILLED_YES);
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    UseCase_PlayerSpawn(client);
}

public void Event_PlayerTeam(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);
    int team = event.GetInt("team");

    UseCase_PlayerTeam(client, team);
}

public void Event_PlayerChangeClass(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    Client_UpdateClassChangeTime(client);
}
