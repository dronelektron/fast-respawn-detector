void UseCase_PlayerSpawn(int client) {
    if (Client_HasApiTimer(client)) {
        return;
    }

    float classChangeDelta = Client_GetClassChangeDelta(client);

    if (classChangeDelta < CLASS_CHANGE_DELTA) {
        int userId = GetClientUserId(client);
        bool isKilled = Client_IsKilled(client);
        float spectatorTime = Client_GetSpectatorTime(client);
        DataPack params = new DataPack();

        params.WriteCell(userId);
        params.WriteCell(isKilled);
        params.WriteFloat(spectatorTime);
        params.Reset();

        Handle timer = CreateTimer(API_CALL_INTERVAL, UseCaseTimer_ApiCall, params, API_TIMER_FLAGS);

        Client_SetApiTimer(client, timer);
    }

    Client_SetKilled(client, KILLED_NO);
    Client_ResetSpectatorTime(client);
}

public Action UseCaseTimer_ApiCall(Handle timer, DataPack params) {
    int userId = params.ReadCell();
    int client = GetClientOfUserId(userId);

    if (client != INVALID_CLIENT) {
        bool isKilled = params.ReadCell();
        float spectatorTime = params.ReadFloat();

        Api_OnClientFastRespawned(client, isKilled, spectatorTime);
        Client_ResetApiTimer(client);
    }

    return Plugin_Continue;
}

public void UseCase_KillApiTimers() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            Client_KillApiTimer(client);
        }
    }
}

public void UseCase_MarkClientsAsNotKilled() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            Client_SetKilled(client, KILLED_NO);
        }
    }
}

void UseCase_PlayerTeam(int client, int team) {
    int lastTeam = Client_GetLastTeam(client);
    bool fromAliveToDeadTeam = UseCase_IsAliveTeam(lastTeam) && UseCase_IsDeadTeam(team);
    bool fromDeadToAliveTeam = UseCase_IsDeadTeam(lastTeam) && UseCase_IsAliveTeam(team);

    if (fromAliveToDeadTeam) {
        Client_UpdateSpectatorStartTime(client);
    } else if (fromDeadToAliveTeam) {
        Client_UpdateSpectatorEndTime(client);
    }

    Client_SetLastTeam(client, team);
}

bool UseCase_IsAliveTeam(int team) {
    return team == TEAM_ALLIES || team == TEAM_AXIS;
}

bool UseCase_IsDeadTeam(int team) {
    return team == TEAM_SPECTATORS;
}
