void UseCase_PlayerSpawn(int client) {
    float classChangeDelta = Client_GetClassChangeDelta(client);

    if (Client_IsKilled(client) && classChangeDelta < CLASS_CHANGE_DELTA) {
        float spectatorsDelta = Client_GetSpectatorsDelta(client);

        Api_OnClientFastRespawned(client, spectatorsDelta);
    }

    Client_SetKilled(client, KILLED_NO);
    Client_ResetSpectatorsTime(client);
}

void UseCase_PlayerTeam(int client, int team) {
    int lastTeam = Client_GetLastTeam(client);
    bool fromAliveToDeadTeam = UseCase_IsAliveTeam(lastTeam) && UseCase_IsDeadTeam(team);
    bool fromDeadToAliveTeam = UseCase_IsDeadTeam(lastTeam) && UseCase_IsAliveTeam(team);

    if (fromAliveToDeadTeam) {
        Client_UpdateSpectatorsStartTime(client);
    } else if (fromDeadToAliveTeam) {
        Client_UpdateSpectatorsEndTime(client);
    }

    Client_SetLastTeam(client, team);
}

bool UseCase_IsAliveTeam(int team) {
    return team == TEAM_ALLIES || team == TEAM_AXIS;
}

bool UseCase_IsDeadTeam(int team) {
    return team == TEAM_SPECTATORS;
}
