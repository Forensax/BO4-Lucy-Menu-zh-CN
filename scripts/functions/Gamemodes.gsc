GameModeHandler(gameModeSelected)
{
    if(!isDefined(level.GameModeSelected)){
        if(!isDefined(gameModeSelected))
        {
            self iPrintLn("无效的游戏模式");
        }
        else if(gameModeSelected == "Gun Game")
        {
            self thread doGunGame();
            level.GameModeSelected=true;
        }else if(gameModeSelected == "All The Weapons")
        {
            self thread doAllWeaponsZM();
            level.GameModeSelected=true;
        }
    }
}

doGunGame()//Haha, thats kinda funny Criptic, Guess what I did here, before you :D
{
        self thread KillAllZombies();
        self thread RoundEdit(15);
        foreach(player in level.players)
    {
        player thread CloseMenu1();
        player thread GunGame();
        player iPrintLn("^1枪^7械^1游^7戏");
        wait 2;
        player iPrintLn("^1玩^7得^1开^7心！");
    }
}
GunGame()
{
        self endon("death");
        self endon("disconnect");
        wait 5;
        keys=GetArrayKeys(level.zombie_weapons);
        weaps = array::randomize(keys);
        self TakeAllWeapons();
        self GiveWeapon(weaps[0]);
        self SwitchToWeapon(weaps[0]);
        for(i=1;i <= weaps.size-1;i++)
    {
        self waittill("zom_kill");
        self iPrintLn("已获得新武器！击杀数：^1"+i);
        self TakeAllWeapons();
        self GiveWeapon(weaps[i]);
        self SwitchToWeapon(weaps[i]);
    }
}

DoAllWeaponsZM()
{
    self thread KillAllZombies();
    self thread RoundEdit(25);
    foreach(player in level.players)
    {
        player thread CloseMenu1();
        player thread AllWeaponsStart();
        player iPrintLn("^1全^2部^3武器轮换");
        wait 2;
        player iPrintLn("^5每 ^645 ^3秒轮换一次武器！");
    }
}

AllWeaponsStart()
{
    self endon("death");
    self endon("disconnect");
    wait 3;
    WeapKeys = GetArrayKeys(level.zombie_weapons_upgraded);
    PapWeaps = array::randomize(WeapKeys);
    self TakeAllWeapons();
    for(;;){
        i = randomIntRange(0, PapWeaps.size - 1);
        self GiveWeapon(PapWeaps[i]);
        self SwitchToWeapon(PapWeaps[i]);
        self iPrintLn("^1已获得新武器");
        wait 45;
    }
}
