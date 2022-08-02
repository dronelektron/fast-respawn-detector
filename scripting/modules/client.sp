static bool g_isKilled[MAXPLAYERS + 1];
static float g_classChangeTime[MAXPLAYERS + 1];
static float g_spectatorsStartTime[MAXPLAYERS + 1];
static float g_spectatorsEndTime[MAXPLAYERS + 1];
static int g_lastTeam[MAXPLAYERS + 1];

void Client_Reset(int client) {
    g_isKilled[client] = KILLED_NO;
    g_classChangeTime[client] = 0.0;
    g_spectatorsStartTime[client] = 0.0;
    g_spectatorsEndTime[client] = 0.0;
    g_lastTeam[client] = TEAM_UNASSIGNED;
}

bool Client_IsKilled(int client) {
    return g_isKilled[client];
}

void Client_SetKilled(int client, bool isKilled) {
    g_isKilled[client] = isKilled;
}

float Client_GetClassChangeDelta(int client) {
    float currentTime = GetGameTime();

    return currentTime - g_classChangeTime[client];
}

void Client_UpdateClassChangeTime(int client) {
    g_classChangeTime[client] = GetGameTime();
}

float Client_GetSpectatorsDelta(int client) {
    return g_spectatorsEndTime[client] - g_spectatorsStartTime[client];
}

void Client_UpdateSpectatorsStartTime(int client) {
    g_spectatorsStartTime[client] = GetGameTime();
}

void Client_UpdateSpectatorsEndTime(int client) {
    g_spectatorsEndTime[client] = GetGameTime();
}

void Client_ResetSpectatorsTime(int client) {
    g_spectatorsStartTime[client] = 0.0;
    g_spectatorsEndTime[client] = 0.0;
}

int Client_GetLastTeam(int client) {
    return g_lastTeam[client];
}

void Client_SetLastTeam(int client, int lastTeam) {
    g_lastTeam[client] = lastTeam;
}
