TeleTo(arg, player)
{
    switch(arg)
    {
        case 0: self setOrigin(player.origin + (+30,0,0)); break;
        case 1: player setOrigin(self.origin+(+30,0,0)); break;
    }
}

ClientFuncs(args, val1)
{
    foreach(player in level.players)
    {
        switch(args)
        {
            case 0: player thread Godmode(); break;
            case 1: player thread BetterUnlimitedAmmo(); break;
            case 2: player thread zm_score::add_to_player_score(40000000); break;
            case 3: player thread GiveAllPerks(); break;
        }
    }
}

ClientHandler(func, player)
{
    player endon("disconnect");
    level endon("game_ended");
    switch(func)
    {
        case 0: player thread Godmode(); break;
        case 1: player thread BetterUnlimitedAmmo(); break;
        case 2: player thread BO4Level55(player); break;
        case 3: player thread PlasmaLoop(); break;
        case 4: player thread GiveAllPerks(); break;
        case 5: player thread GetSelfRes(); break;
        case 6: player thread BO4_UnlockAll(player); break;
        case 7: player thread BO4_MaxLevels(player); break;
        case 8: player thread zm_score::add_to_player_score(40000000); break;
        case 9: player thread zm_score::minus_to_player_score(40000000); break;
    }
}

S(Message)
{
    self iPrintLn(Message);
}

SetSelfRevives(count)
{
    foreach(player in level.players){
        player zm_laststand::function_3d685b5f(count);
        player iPrintLn("已获得 "+count+" 次自救机会");
    }
}

DownPlayer(player)
{
    player disableInvulnerability();
    player doDamage(player.health + 1, player.origin);
    self iPrintLn("玩家已被^1击倒");
    player iPrintLn("你被 "+self.name+" 击倒了");
}

KillPlayer(player)
{
    player notify("player_suicide");
    player zm_laststand::bleed_out();
    self iPrintLn("已击杀 "+player.name);
    player iPrintLn("你被 "+self.name+" 击杀了");
}

sendToJail(player)
{
    if(!isDefined(level.JailCoords)){
        self iPrintLn("当前地图没有设置监狱坐标"); return;}
    
    player setOrigin(level.JailCoords);
    player iPrintLn("你已被送入监狱！");
}

TakeAllPlayerWeaps(player)
{
    player takeAllWeapons();
    player iPrintLn("你的武器已被移除！");
}

PlayerMessage(val, player)//remove pointless messages
{
    foreach(client in level.players)
    {
        switch(val)
        {
            case 0: client S(player.name+" ^2正在使用模组菜单！");break;
            case 1: client S(player.name+" ^5正在作弊！");break;
            case 2: client S(player.name+" ^1是个可恶的黑客！"); break;
            case 3: client S(player.name+" ^4僵尸模式玩得太差了！"); break;
            case 4: client S(player.name+" ^3胆子真小"); break;
        }
    }
}
