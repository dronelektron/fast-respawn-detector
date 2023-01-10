static GlobalForward g_onClientFastRespawned = null;

void Api_Create() {
    g_onClientFastRespawned = new GlobalForward("OnClientFastRespawned", ET_Ignore, Param_Cell, Param_Cell, Param_Float);
}

void Api_Destroy() {
    delete g_onClientFastRespawned;
}

void Api_OnClientFastRespawned(int client, bool isKilled, float spectatorTime) {
    Call_StartForward(g_onClientFastRespawned);
    Call_PushCell(client);
    Call_PushCell(isKilled);
    Call_PushFloat(spectatorTime);
    Call_Finish();
}
