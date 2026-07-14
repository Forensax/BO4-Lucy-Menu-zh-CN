
BO4newOrigin(Coords, Location)
{
    if(!isDefined(Location))
        Location = "未定义";
    self SetOrigin(Coords);
    self iPrintLn("已传送到 "+Location);
}
