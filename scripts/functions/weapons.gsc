GiveSvalinnGuard()
{
   self GiveWeapon(getWeapon("zhield_frost_dw"));
   self aat::acquire(getweapon("zhield_frost_dw"), "zm_aat_frostbite");
   self zm_pap_util::repack_weapon(getweapon("zhield_frost_dw"), 4);
   self.var_5ba94c1e = 1;
   self iPrintLn("已获得 ^2Svalinn Guard");
}


GiveClientWeapon(WeaponName, player)
{
    if(zm_loadout::is_melee_weapon(getweapon(WeaponName)) || WeaponName == "stake_knife")
    {
        player takeweapon( player zm_loadout::get_player_melee_weapon());
        w_current = player.currentweapon;
        player zm_melee_weapon::award_melee_weapon( WeaponName );
        player zm_weapons::give_build_kit_weapon(getweapon(WeaponName));
        player switchtoweapon( w_current );
        return;
    }
    self zm_weapons::give_build_kit_weapon(getweapon(WeaponName));
    self switchtoweapon(getweapon(WeaponName));
    wait .1;
    player giveMaxAmmo(getweapon(WeaponName));
    wait .1;
    player switchToWeapon(getweapon(WeaponName));
    player iPrintLn("已获得 "+WeaponName);
}
DropWeapon()
{
    Current_Weapon = self GetCurrentWeapon();
    self DropItem(Current_Weapon);
    self iPrintLn("^2已丢弃当前武器");
}

TakeWeapons()
{
    weapon = self getCurrentWeapon();
    self TakeAllWeapons();
    wait .5;
    self TakeWeapon(weapon);
}

TakeCurrentWeapon()
{
    weapon = self getCurrentWeapon();
    self TakeWeapon(weapon);
    wait .5;
    self TakeWeapon(weapon);
}

acquireaat(id) {
    weapon = self getCurrentWeapon();
    self thread aat::acquire(weapon, id);
} 

RemoveEff()
{
    weapon = self GetCurrentWeapon();
    self thread aat::remove(weapon);
    wait .5;
    self switchToWeapon(weapon);
    self iPrintLn("已移除强化效果");
}

bo4_CamoGiver(Camo) 
{
    Weapon = self GetCurrentWeapon();
    self TakeWeapon(Weapon);
    self GiveWeapon(Weapon, self CalcWeaponOptions(Int(Camo), 1, 1, true, true, true, true));
}

UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();
    self TakeWeapon(weapon);
    wait .1;
    self zm_weapons::give_build_kit_weapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self SwitchToWeapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self iPrintLn("^2当前武器已强化！");
}

magicbullets()
{
    self.magicBullets = isDefined(self.magicBullets) ? undefined : true;
    if(isDefined(self.magicBullets))
    {
        self.bulletEffectType = "launcher_standard_t8_upgraded";
        self iPrintLn("魔法子弹已开启，效果：火箭发射器");
        while(isDefined(self.magicBullets))
        {
            self waittill(#"weapon_fired");
            MagicBullet(getWeapon(self.bulletEffectType), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
            wait .25;
        }
    }
    else 
    {
        self iPrintLn("魔法子弹已^1关闭");
        self.bulletEffectType=undefined;
    }
}

changeBulletType(val)
{
    if(isDefined(self.bulletEffectType))
    {
        switch(val)
        {
            case 0: self.bulletEffectType=  "minigun"; self iPrintLn("弹丸效果已设为：Minigun"); break;
            case 1: self.bulletEffectType = "special_ballisticknife_t8_dw_upgraded"; self iPrintLn("弹丸效果已设为：Ballistic Knife"); break;
            case 2: self.bulletEffectType = "launcher_standard_t8_upgraded"; self iPrintLn("弹丸效果已设为：火箭发射器"); break;
            case 3: self.bulletEffectType = "ray_gun"; self iPrintLn("弹丸效果已设为：Ray Gun"); break;
        }
    }
    else
    {
        self iPrintLn("请先开启魔法子弹");
    }
}
