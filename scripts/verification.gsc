setVerification(a, player, msg)
{
    if(player IsHost() || player getVerification() == a || player == self)
    {
        if(isDefined(msg))
        {
            if(player IsHost())
                return self iPrintlnBold("^1错误：^7无法修改房主权限");
            if(player getVerification() == a)
                return self iPrintlnBold("^1错误：^7该玩家已经是 ^2" + level.MenuStatus[a]);
            if(player == self)
                return self iPrintlnBold("^1错误：^7无法修改自己的权限");
        }
        return;
    }
    
    player.playerSetting["verification"] = level.MenuStatus[a];
    player iPrintlnBold("你的权限已设为 ^2" + player.playerSetting["verification"]);
    player.menuParent = [];
    if(player isInMenu())
        player closeMenu1();
    player.menu["currentMenu"] = "Main";
    player.menu["curs"][player.menu["currentMenu"]] = 0;
    
    player runMenuIndex("Main");
}

SetVerificationAllPlayers(a, msg)
{
    foreach(player in level.players)
        self setVerification(a, player);
    if(IsDefined(msg))
        self iPrintlnBold("全体玩家权限已设为 ^2" + level.MenuStatus[a]);
}

getVerification()
{
    if(!isDefined(self.playerSetting["verification"]))
        return 0;
    
    for(a=0;a<level.MenuStatus.size;a++)
        if(self.playerSetting["verification"] == level.MenuStatus[a])
            return a;
}

hasMenu()
{
    if(self getVerification() > 0)
        return true;
    return false;
}
