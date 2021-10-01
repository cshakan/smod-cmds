#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#pragma newdecls required
#pragma semicolon 1


public Plugin myinfo =
{
	name = "test",
	author = "sunder",
	description = "testing",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};


public void OnPluginStart()
{
	RegAdminCmd("sm_heal", Command_Heal)
}

public Action Command_Heal(int client, int args)
{
	char arg1[32], arg2[32];

	int heal = 300;

	GetCmdArg(1, arg1, sizeof(arg1));
	if (args >= 2)
	{
		GetCmdArg(2, arg2, sizeof(arg2));
		heal = StringToInt(arg2);
	}

	int target = FindTarget(client, arg1);
	if (target == -1)
	{
		return Plugin_Handled;
	}

	int GetClientHealth(int client);
	heal += GetClientHealth;
	SetEntityHealth(target, heal);
	ReplyToCommand(client, "[SM] You healed %N for %d health!", target, heal);
 
	return Plugin_Handled;
}