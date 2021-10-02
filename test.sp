#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#pragma newdecls required
#pragma semicolon 1

bool isGodMode[MAXPLAYERS] = false;

public Plugin myinfo =
{
	name = "godmod",
	author = "sunder",
	description = "testing",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}

public void OnPluginStart()
{
	RegAdminCmd("sm_godmode", Command_Godmode, ADMFLAG_SLAY);
	LoadTranslations("common.phrases.txt");
}

public Action Command_Godmode(int client, int args)
{
    if(args == 0)
    {
        ReplyToCommand(client, "put a target please :)");
        return Plugin_Handled;
    }

    char arg1[32];
    GetCmdArg(1, arg1, sizeof(arg1));

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


    for(int i = 0; i < target_count; ++i)
    {
        if(!isGodMode[client])
        {
            if(IsPlayerAlive(target_list[i])){
            SetEntProp(target_list[i], Prop_Data, "m_takedamage", 0);
            isGodMode[target_list[i]] = true;
            LogAction(client, target_list[i], "\"%L\" set \"%L\" to godmode.", client, target_list[i]);
            }
        }
        else
        {
            if(IsPlayerAlive(target_list[i])){
            SetEntProp(target_list[i], Prop_Data, "m_takedamage", 2);
            isGodMode[target_list[i]] = false;
            LogAction(client, target_list[i], "\"%L\" set \"%L\" off of godmode.", client, target_list[i]);
            }
        }
    }

    if (tn_is_ml)
	{
		ReplyToCommand(client, "[SM] Toggled godmode on %t!", target_name);
	}
	else
	{
		ReplyToCommand(client, "[SM] Toggled godmode on %s!", target_name);
	}
    return Plugin_Handled;
}