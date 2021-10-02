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
	RegAdminCmd("sm_sethp", Command_SetHp, ADMFLAG_SLAY);
	LoadTranslations("common.phrases.txt");
}

public Action Command_SetHp(int client, int args)
{
	char arg1[32], arg2[32];

	int heal = 300;

	GetCmdArg(1, arg1, sizeof(arg1));
	if (args >= 2)
	{
		GetCmdArg(2, arg2, sizeof(arg2));
		heal = StringToInt(arg2);
	}

	char target_name[MAX_TARGET_LENGTH];
	int target_list[MAXPLAYERS], target_count;
	bool tn_is_ml;

	if ((target_count = ProcessTargetString(
		arg1,
		client,
		target_list,
		MAXPLAYERS,
		COMMAND_FILTER_ALIVE,
		target_name,
		sizeof(target_name),
		tn_is_ml)) <= 0)
	{
		ReplyToTargetError(client, target_count);
		return Plugin_Handled;
	}
	
	for (int i = 0; i < target_count; i++)
	{
		SetEntityHealth(target_list[i], heal);
		LogAction(client, target_list[i], "\"%L\" set \"%L\" hp (%d)", client, target_list[i], heal);
	}
 
	if (tn_is_ml)
	{
		ReplyToCommand(client, "[SM] Set %t to %d hp!", target_name, heal);
	}
	else
	{
		ReplyToCommand(client, "[SM] Set %s to %d hp!", target_name, heal);
	}

	return Plugin_Handled;
}
