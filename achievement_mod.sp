#include <tf2_stocks>
#include <sdktools>
#include <sdkhooks>

new g_Steps[][2] = {
	{127, 167}, // General
	{1001, 1041}, // Scout
	{1101, 1142}, // Sniper
	{1201, 1243}, // Soldier
	{1301, 1344}, // Demoman
	{1401, 1439}, // Medic
	{1501, 1539}, // Heavy
	{1601, 1641}, // Pyro
	{1701, 1738}, // Spy
	{1801, 1838}, // Engineer
	{1901, 1928}, // Halloween 
	{2001, 2008}, // Replay
	{2101, 2101}, // Christmas
	{2201, 2212}, // Foundry
	{2301, 2352}, // MvM
	{2401, 2412}, // Doomsday
	{2501, 2501}, // Process
	{2601, 2601}, // Standin
	{2701, 2705}, // Snakewater
	{2801, 2805} // Powerhouse

};

new String:g_StepNames[][] = {
	"General",
	"Scout",
	"Sniper",
	"Soldier",
	"Demoman",
	"Medic",
	"Heavy",
	"Pyro",
	"Spy",
	"Engineer",
	"Halloween",
	"Replay",
	"Christmas",
	"Foundry",
	"MvM",
	"Doomsday",
	"Process",
	"Standin",
	"Snakewater",
	"Powerhouse"
};


new TFClassType:g_RequiredClass[] = {
	TFClass_Unknown,
	TFClass_Scout,
	TFClass_Sniper,
	TFClass_Soldier,
	TFClass_DemoMan,
	TFClass_Medic,
	TFClass_Heavy,
	TFClass_Pyro,
	TFClass_Spy,
	TFClass_Engineer,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown,
	TFClass_Unknown
};

public Plugin:myinfo =
{
	name = "[TF2] Achievement Mod",
	author = "Kuroiwa, sunder",
	description = "Provides !givemeall and !giveitems commands that rewards clients with achievements.",
	version = "2.0",
	url = "http://sourcemod.net"
};

new g_Step[MAXPLAYERS + 1];

public OnPluginStart() 
{
	CreateConVar("sm_achmod_version", "2.0", "Achievement Mod Plugin Version", FCVAR_NOTIFY|FCVAR_DONTRECORD);

	RegConsoleCmd("sm_giveme", Command_GiveMe, "Unlocks a specific achievement for you.");
	RegConsoleCmd("sm_givemeall", Command_GiveMeAll, "Unlocks all achievements for you.");
	RegConsoleCmd("sm_giveitems", Command_GiveItems, "Unlocks item achievements for you.");
}

public Action:Command_GiveMe(client, args)
{
	char arg1[32];

	if (args < 1)
	{
		PrintToChat(client, "Use this link to find achievement ids: https://github.com/nosoop/stocksoup/blob/master/tf/enum/achievements.inc");

		return Plugin_Handled;
	}
	GetCmdArg(1, arg1, sizeof(arg1));
	int id = StringToInt(arg1, 10);
	Unlock(client, id);
	return Plugin_Handled;
}

public Action:Command_GiveItems(client, args)
{
	UnlockNamed(client, 1036, "scout1");// Scout
	UnlockNamed(client, 1037, "scout2");
	UnlockNamed(client, 1038, "scout3");
	 
	UnlockNamed(client, 1136, "Sniper Milestone 1");
	UnlockNamed(client, 1137, "Sniper Milestone 2");
	UnlockNamed(client, 1138, "Sniper Milestone 3");
	 
	UnlockNamed(client, 1236, "Soldier Milestone 1");
	UnlockNamed(client, 1237, "Soldier Milestone 2");
	UnlockNamed(client, 1238, "Soldier Milestone 3");
	 
	UnlockNamed(client, 1336, "Demoman Milestone 1");
	UnlockNamed(client, 1337, "Demoman Milestone 2");
	UnlockNamed(client, 1338, "Demoman Milestone 3");
	 
	UnlockNamed(client, 1437, "Medic Milestone 1");
	UnlockNamed(client, 1438, "Medic Milestone 2");
	UnlockNamed(client, 1439, "Medic Milestone 3");
	 
	UnlockNamed(client, 1537, "Heavy Milestone 1"); // Heavy
	UnlockNamed(client, 1538, "Heavy Milestone 2");
	UnlockNamed(client, 1539, "Heavy Milestone 3");
	 
	UnlockNamed(client, 1637, "Pyro Milestone 1"); // Pyro
	UnlockNamed(client, 1638, "Pyro Milestone 2");
	UnlockNamed(client, 1639, "Pyro Milestone 3");
	 
	UnlockNamed(client, 1735, "Spy Milestone 1"); // Spy
	UnlockNamed(client, 1736, "Spy Milestone 2");
	UnlockNamed(client, 1737, "Spy Milestone 3");
	 
	UnlockNamed(client, 1801, "Engineer Milestone 1"); // Engy
	UnlockNamed(client, 1802, "Engineer Milestone 2");
	UnlockNamed(client, 1803, "Engineer Milestone 3");
	 
	UnlockNamed(client, 2004, "Star of My Own Show");
	UnlockNamed(client, 2006, "Local Cinema Star");
	 
	UnlockNamed(client, 2212, "Foundry Milestone");
	
	UnlockNamed(client, 2412, "Doomsday Milestone");
	
	UnlockNamed(client, 156, "Fresh Pair Of Eyes");

	UnlockNamed(client, 1928, "Carnival of Carnage: Step Right Up");
	UnlockNamed(client, 1927, "Carnival of Carnage: Bumper to Bumper to Bumper");

	UnlockNamed(client, 1902, "Ghastly Gibus Grab");
	UnlockNamed(client, 1901, "Candy Coroner");
	UnlockNamed(client, 1906, "Sleepy Ho110WND");
	UnlockNamed(client, 1912, "A Lovely Vacation Spot");
	UnlockNamed(client, 1911, "Dive Into a Good Book");
	UnlockNamed(client, 1909, "Gored!");
	UnlockNamed(client, 1921, "Helltower: The Mann-tastic Four");
	UnlockNamed(client, 1921, "Helltower: Hat Out of Hell");

	UnlockNamed(client, 167, "Jackpot!");
	UnlockNamed(client, 166, "Tune Merasmus's Multi-Dimensional Television");

	UnlockNamed(client, 2301, "Steel Fragnolias");

	 
	return Plugin_Handled;
}

public Action:Command_GiveMeAll(client, args)
{
	if(g_Step[client] > 0) 
	{
		return Plugin_Handled;
	}
	
	if(!IsPlayerAlive(client))
	{
		PrintToChat(client, "[SM] You must be alive to use !givemeall command");
		return Plugin_Handled;
	}
	
	TF2_RespawnPlayer(client);
	
	
	g_Step[client] = 0;
	CreateTimer(0.5, Timer_PrepNextStep, GetClientUserId(client));
	return Plugin_Handled;
}

public Action:Timer_PrepNextStep(Handle:timer, any:userid) 
{
	new client = GetClientOfUserId(userid);
	if(!client) {
		return;
	}
	
	TF2_RemoveAllWeapons(client);
	SetEntityMoveType(client, MOVETYPE_NONE);
	
	if(g_RequiredClass[g_Step[client]] != TFClass_Unknown) {
		TF2_SetPlayerClass(client, g_RequiredClass[g_Step[client]]);
	}
	
	PrintHintText(client, "Unlocking %s achievements...", g_StepNames[g_Step[client]]);
	
	CreateTimer(1.0, Timer_DoNextStep, userid);
}

public Action:Timer_DoNextStep(Handle:timer, any:userid)
{
	new client = GetClientOfUserId(userid);
	if(!client) {
		return;
	}
	
	for(new i = g_Steps[g_Step[client]][0]; i <= g_Steps[g_Step[client]][1]; i++) {
		Unlock(client, i);
	}
	
	if(++g_Step[client] >= sizeof(g_Steps)) {
		PrintToChat(client, "[SM] All achievements has been unlocked.");
		g_Step[client] = 0;
		ForcePlayerSuicide(client);
		SDKHooks_TakeDamage(client, 0, 0, 5000.0);
	} else {
		CreateTimer(4.0, Timer_PrepNextStep, userid);
	}
}

UnlockNamed(client, id, String:achname[]) {
	new Handle:bf = StartMessageOne("AchievementEvent", client, USERMSG_RELIABLE);
	BfWriteShort(bf, id);
	EndMessage();
}

Unlock(client, id) {
	new Handle:bf = StartMessageOne("AchievementEvent", client, USERMSG_RELIABLE);
	BfWriteShort(bf, id);
	EndMessage();
}