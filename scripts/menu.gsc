runMenuIndex(menu)
{
    self endon("disconnect");

    if(!isDefined(menu))
        menu = "Main";
    
    switch(menu)
    {
        case "Main":
            self addMenu(menu, level.menuName);
            if(self getVerification() > 0)
            {
                self addOpt("个人功能", &newMenu, "Personal Menu");
                self addOpt("娱乐功能", &newMenu, "Fun Menu");
                self addOpt("账号功能", &newMenu, "Account Menu");
                self addOpt("传送功能", &newMenu, "Teleport Menu");
                if(self getVerification() > 1)
                {
                    self addOpt("药剂功能", &newMenu, "Elixir Menu");
                    self addOpt("武器和道具", &newMenu, "Weapons and items Menu");
                    self addOpt("专家武器", &newMenu, "Specialist Menu");
                    self addOpt("掉落物", &newMenu, "Powerups Menu");
                    self addOpt("僵尸功能", &newMenu, "Zombie Menu");
                    if(self getVerification() > 2)
                    {
                        self addOpt("房间设置", &newMenu, "Lobby Settings");
                        self addOpt("神秘箱", &newMenu, "Mystery Box Menu");
                        if(self getVerification() > 3)
                        {
                            if(self IsHost())
                                self addOpt("房主功能", &newMenu, "Host Menu");//will only display for the host
                            self addOpt("玩家管理", &newMenu, "Players");//anything here and below show for all clients
                            self addOpt("全体玩家功能", &newMenu, "AllClient");
                            if(!isDefined(level.GameModeSelected) && self IsHost())
                                self addOpt("游戏模式", &newMenu, "GameModes");
                        }
                    }
                }
            }
        break;
        case "Personal Menu":
            self addMenu(menu, "个人功能");
                self addOptBool(self.godmode, "无敌模式", &Godmode);
                self addOptBool(self.demiMode, "半无敌模式", &DemiGod);
                self addOptBool(self.betterUnlimitedAmmo,"无限弹药", &BetterUnlimitedAmmo);
                self addOptBool(self.Noclip, "穿墙移动", &NoclipToggle1, self);
                self addOptBool(self.recoil, "无后坐力", &ToggleRecoil);
                self addOptBool(self.UnlimitedSprint, "无限奔跑", &UnlimitedSprint);
                self addOptBool(self.PSpeed, "双倍移速", &PSpeed);
                self addOptBool(self.killAura, "杀戮光环", &ToggleKillAura);//fixed 22/10/25 theunknowncod3r
                self addOpt("增加自救次数", &GetSelfRes);
                self addOpt("立即自救", &BO4Rev);
                self addOpt("获得全部技能", &GiveAllPerks);
                self addOpt("选择技能", &newMenu, "Perk Selection");
                self addOpt("点数功能", &newMenu, "Score Menu");
                self addOpt("开启全部门", &BO4_OpenAllDoors);
        break;
        case "Perk Selection":
            self addMenu(menu, "选择技能");
                for(i = 0; i < level._PerkStrings.size; i++)
                    self addOpt(level._PerkNames[i], &GivePlayerPerk, level._PerkStrings[i], self);
        break;
        case "Score Menu":
            self addMenu(menu, "点数功能");
                self addOptBool(self.onlyIncrease, "点数只增不减", &ScoreOnlyIncreases);
                self addOpt("获得最大点数", &PlayerGiveScore, 4000000);
                self addOpt("扣除最大点数", &PlayerTakeScore, 4000000);
                self addOptIncSlider("增加点数", &PlayerGiveScore, 0, 0, 1000000, 10000);
                self addOptIncSlider("扣除点数", &PlayerTakeScore, 0, 0, 1000000, 10000);
        break;

        case "Elixir Menu":
            self addMenu(menu, "药剂功能");//Should be complete
            self addOpt("超级药剂", &newMenu, "Mega Elixirs");
            self addOpt("传奇药剂", &newMenu, "Legendary Elixirs");
            self addOpt("稀有药剂", &newMenu, "Rare Elixirs");
            self addOpt("普通药剂", &newMenu, "Common Elixirs");
            self addOpt("经典药剂", &newMenu, "Classic Elixirs");
        break;
        case "Mega Elixirs":
            self addMenu(menu, "超级药剂");
            for(i = 0; i < level._MegaElixirs.size; i++)
                self addOpt(level._MegaElixirNames[i], &GiveElixir, level._MegaTypes[i], "zm_bgb_" + level._MegaElixirs[i]);
        break;

        case "Legendary Elixirs":
            self addMenu(menu, "传奇药剂");
            for(i = 0; i < level._LegendaryElixirs.size; i++)
                self addOpt(level._LegendaryElixirNames[i], &GiveElixir, level._LegendaryTypes[i], "zm_bgb_" + level._LegendaryElixirs[i]);
        break;

        case "Rare Elixirs":
            self addMenu(menu, "稀有药剂");
            for(i = 0; i < level._RareElixirs.size; i++)
                self addOpt(level._RareElixirNames[i], &GiveElixir, level._RareTypes[i], "zm_bgb_" + level._RareElixirs[i]);
        break;

        case "Common Elixirs":
            self addMenu(menu, "普通药剂");
            for(i = 0; i < level._CommonElixirs.size; i++)
                self addOpt(level._CommonElixirNames[i], &GiveElixir, level._CommonTypes[i], "zm_bgb_" + level._CommonElixirs[i]);
        break;

        case "Classic Elixirs":
            self addMenu(menu, "经典药剂");
            for(i = 0; i < level._ClassicElixirs.size; i++)
                self addOpt(level._ClassicElixirNames[i], &GiveElixir, level._ClassicTypes[i], "zm_bgb_" + level._ClassicElixirs[i]);
        break;
        case "Map Selection":
            self addMenu(menu, "选择地图");
                self addOpt("IX", &ChangeMap, "zm_towers");
                self addOpt("亡者之血", &ChangeMap, "zm_escape");
                self addOpt("绝望航程", &ChangeMap, "zm_zodt8");
                self addOpt("亡者之夜", &ChangeMap, "zm_mansion");
                self addOpt("远古邪恶", &ChangeMap, "zm_red");
                self addOpt("阿尔法·欧米伽", &ChangeMap, "zm_white");
                self addOpt("机密", &ChangeMap, "zm_office");
                self addOpt("冰天雪地", &ChangeMap, "zm_orange");
        break;
        case "Teleport Menu": //Coords, Loc name for iprint
            self addMenu(menu, "传送功能");
            switch(BO4GetMap()){
                case "IX": 
                    self addOpt("宙斯技能机", &BO4newOrigin, (1993.89, -479.343, 212.125), "宙斯技能机");
                    self addOpt("奥丁技能机", &BO4newOrigin, (2020.7, 341.974, 215.125), "奥丁技能机");
                    self addOpt("拉技能机", &BO4newOrigin, (-1809.33, 423.894, 212.125), "拉技能机");
                    self addOpt("达努技能机", &BO4newOrigin, (-1922.34, -443, 216.313), "达努技能机");
                    self addOpt("挑战台", &BO4newOrigin, (58.3157, -24.4512, 80.125), "挑战台");
                    self addOpt("斗兽坑", &BO4newOrigin, (151.776, 1802.6, -365.875), "斗兽坑");
                    break;
                case "Blood":
                    self addOpt("里希托芬实验室", &BO4newOrigin, (9953.67, 11261.1, 256.125), "里希托芬实验室");
                    self addOpt("西部场地", &BO4newOrigin, (8661.22, 10287.5, 513.077), "西部场地");
                    self addOpt("一号电源", &BO4newOrigin, (8892.1, 8851.01, 423.469), "一号电源");
                    self addOpt("新工业区", &BO4newOrigin, (7083.19, 11134.6, 311.625), "新工业区");
                    self addOpt("操场", &BO4newOrigin, (4836.18, 10932.7, 1016.13), "操场");
                    self addOpt("食堂", &BO4newOrigin, (2589.46, 9645.69, 1336.13), "食堂");
                    self addOpt("二楼牢房", &BO4newOrigin, (869.781, 9690.19, 1443.13), "二楼牢房");
                    self addOpt("典狱长办公室", &BO4newOrigin, (-588.591, 8613.38, 1336.13), "典狱长办公室");
                    self addOpt("典狱长住宅", &BO4newOrigin, (-2382.56, 7745.07, 1304.13), "典狱长住宅");
                    self addOpt("城堡隧道", &BO4newOrigin, (420.385,9506.33,1104.13), "城堡隧道");
                    self addOpt("64号楼发电站", &BO4newOrigin, (-1037.37, 6576.8, 70.1152), "64号楼发电站");
                    self addOpt("码头", &BO4newOrigin, (-543.102, 5451.18, -71.875), "码头");
                    self addOpt("监狱屋顶", &BO4newOrigin, (3467.25, 9740.63, 1704.13), "监狱屋顶");
                    break;
                case "Voyage":
                    self addOpt("艉楼甲板", &BO4newOrigin, (6.67061, 4843.74, 1216.12), "艉楼甲板");
                    self addOpt("锅炉房", &BO4newOrigin, (8.88611, 622.069, 320.125), "锅炉房");
                    self addOpt("宴会厅", &BO4newOrigin, (-457.054, -775.388, 1056.13), "宴会厅");
                    self addOpt("头等舱休息室", &BO4newOrigin, (-160.682, -612.253, 1216.13), "头等舱休息室");
                    self addOpt("前甲板", &BO4newOrigin, (118.374, -4506.12, 928.125), "前甲板");
                    break;
                case "Classified":
                    self addOpt("会议室", &BO4newOrigin, (-911.255, 2531.01, 16.125), "会议室");
                    self addOpt("主办公室", &BO4newOrigin, (333.581, 2069.82, 16.125), "主办公室");
                    self addOpt("作战室上层", &BO4newOrigin, (-1468.32, 2040.02, -303.875), "作战室上层");
                    self addOpt("作战室下层", &BO4newOrigin, (-317.895, 2114.2, -511.875), "作战室下层");
                    self addOpt("实验室", &BO4newOrigin, (333.581, 2069.82, 16.125), "实验室");
                    break;
                case "Dead":
                    self addOpt("哨兵神器", &BO4newOrigin, (-2.56008, -928.784, -7.875), "哨兵神器");
                    self addOpt("北中庭桥", &BO4newOrigin, (11.2006, 956.359, 25.7624), "北中庭桥");
                    self addOpt("卧室", &BO4newOrigin, (1727.24, 1165.29, -7.875), "卧室");
                    self addOpt("酒窖", &BO4newOrigin, (-249.745, -1334.12, -415.875), "酒窖");
                    self addOpt("陵墓", &BO4newOrigin, (-4474.56, 524.39, 272.125), "陵墓");
                    self addOpt("图书馆", &BO4newOrigin, (-1512.27, 485.992, -209.684), "图书馆");
                    self addOpt("温室实验室", &BO4newOrigin, (4356.48, -73.3307, -439.875), "温室实验室");
                    self addOpt("森林", &BO4newOrigin, (-13.9522, 5562.84, -783.936), "森林");
                    break;
                case "AE":
                    self addOpt("阿波罗神殿", &BO4newOrigin, (-786.167, -867.222, 64.125), "阿波罗神殿");
                    self addOpt("圆形剧场", &BO4newOrigin, (-1990.29, 1212.24, 252.125), "圆形剧场");
                    self addOpt("斯巴达纪念碑", &BO4newOrigin, (803.154, -4110.64, -815.908), "斯巴达纪念碑");
                    self addOpt("悲伤之河", &BO4newOrigin, (-1220.23, 6305.58, 946.825), "悲伤之河");
                    self addOpt("悬崖遗迹", &BO4newOrigin, (-2715.52, 7363.74, 527.862), "悬崖遗迹");
                    self addOpt("巨蟒小径", &BO4newOrigin, (202.279, 8547.08, 434.117), "巨蟒小径");
                    break;
                case "AO":
                    self addOpt("安全检查站", &BO4newOrigin, (68.2689, -3217.63, 65.625), "安全检查站");
                    self addOpt("Rushmore", &BO4newOrigin, (1024.37, -2085.02, -39.875), "Rushmore");
                    self addOpt("APD 审讯室", &BO4newOrigin, (-924.275, -1822.22, -50.875), "APD 审讯室");
                    self addOpt("死胡同", &BO4newOrigin, (-92.3641, 648.275, -61.125), "死胡同");
                    self addOpt("绿屋", &BO4newOrigin, (-1178.23, 737.475, 78.125), "绿屋");
                    self addOpt("黄屋", &BO4newOrigin, (1201.23, 309.127, 77.125), "黄屋");
                    self addOpt("床铺区", &BO4newOrigin, (-40.4824, 1132.1, -415.875), "床铺区");
                    self addOpt("APD 控制室", &BO4newOrigin, (-160.155, -2061.96, -231.875), "APD 控制室");
                    break;
                case "Tag":
                    self addOpt("码头", &BO4newOrigin, (1382.79, 3483.08, 26.625), "码头");
                    self addOpt("泻湖", &BO4newOrigin, (1838.13, 618.756, 7.74777), "泻湖");
                    self addOpt("灯塔湾", &BO4newOrigin, (36.2677, 646.928, 134.026), "灯塔湾");
                    self addOpt("灯塔顶部", &BO4newOrigin, (133.577, 1406.61, 864.125), "灯塔顶部");
                    self addOpt("洞穴", &BO4newOrigin, (-2008.52, 1986.8, 167.866), "洞穴");
                    self addOpt("阳光甲板", &BO4newOrigin, (-626.267, -1333.58, 637.176), "阳光甲板");
                    self addOpt("前甲板", &BO4newOrigin, (2274.94, -2836.93, 315.773), "前甲板");
                    self addOpt("篝火", &BO4newOrigin, (2299.56, -690.696, 5.1327), "篝火");
                    self addOpt("人体注入室", &BO4newOrigin, (-3298.49, 4215.59, 1176.13), "人体注入室");
                    self addOpt("秘密地点 :D", &BO4newOrigin, (-7432.51, -24841.3, 13.5001), "秘密地点 :D");
                    break;
            }
        break;
        case "Fun Menu":
            self addMenu(menu, "娱乐功能");
            self addOpt("生成分身", &Clone);
	        self addOpt("隐藏界面", &HUDDisable);
            self addOptBool(self.thirdperson, "第三人称", &thirdperson);
            self addOpt("播放彩蛋歌曲", &PlayAudioToPlayers, "ee_song");
            self addOpt("播放彩蛋歌曲 2", &PlayAudioToPlayers, "ee_song_2");
            self addOptBool(self.aimbot, "自动瞄准", &bo4_toggleaimbot);
            self addOptBool(self.TeleGun, "传送枪", &StartTeleGun);
            self addOptBool(self.HideWeapon, "隐藏武器", &HideGun);
            self addOptBool(self.Multijump, "多段跳", &Multijump);
            self addOptBool(self.FloatingZombies, "漂浮僵尸", &FloatingZombies);
            self addOptBool(self.ForcingTheHost, "强制房主", &ForceHostToggle);
            self addOpt("召唤 Luna 狼", &LunaWolf);
            self addOpt("保存位置", &SaveLocation, 0);
            self addOpt("载入位置", &SaveLocation, 1);
        break;
        case "Lobby Settings":
            self addMenu(menu, "房间设置");
                self addOptBool(level.BO4NoFallD, "无摔落伤害", &BO4NoFallDam);
                self addOptBool(level.SuperJump, "超级跳跃", &SuperJump);
                self addOptBool(level.SuperSpeed, "超级速度", &SuperSpeed);
                self addoptBool(level.B4Gravity, "低重力", &B4Gravity);
                self addOpt("添加机器人", &bo4_AddBotsToGame);
                self addOptBool(self.AntiQuit, "防止退出", &AntiQuit);
                self addOpt("禁止加入", &AntiJoin);
        break;
        case "Weapons and items Menu":
            self addMenu(menu, "武器功能");
            self addOpt("普通武器和道具", &newMenu, "Normal Weapons and items");
            self addOpt("强化武器", &newMenu, "Upgraded Weapons");
            self addOpt("弹丸效果", &newMenu, "Bullets Menu");
            self addOpt("选择迷彩", &newMenu, "Camo Selector");
            self addOpt("强化当前武器", &UpgradeWeapon);
            self addOpt("强化效果", &newMenu, "Pack a Punch Effects");
            self addOpt("丢弃当前武器", &DropWeapon);
            self addOpt("移除全部武器", &TakeWeapons);
            self addOpt("移除当前武器", &TakeCurrentWeapon);
            break;
        case "Specialist Menu":
        self addMenu(menu, "专家武器");
            switch(BO4GetMap())
            {
                case "Blood":
                case "Classified":
                case "AO":
                case "Tag":
                    self addOpt("火焰喷射器", &GiveClientWeapon, "hero_flamethrower_t8_lv3", self);
                    self addOpt("武士刀", &GiveClientWeapon, "hero_katana_t8_lv3", self);
                    self addOpt("诸神黄昏", &GiveClientWeapon, "hero_gravityspikes_t8_lv3", self);
                    self addOpt("迷你机枪", &GiveClientWeapon, "hero_minigun_t8_lv3", self);
                    break;

                case "Voyage":
                case "Dead":
                case "IX":
                case "AE":
                    self addOpt("环刃", &GiveClientWeapon, "hero_chakram_lv3", self);
                    self addOpt("战锤", &GiveClientWeapon, "hero_hammer_lv3", self);
                    self addOpt("权杖", &GiveClientWeapon, "hero_scepter_lv3", self);
                    self addOpt("毒蛇与巨龙", &GiveClientWeapon, "hero_sword_pistol_lv3", self);
                    break;
            }
        break;    
        case "Bullets Menu":
        self addMenu(menu, "弹丸效果");
            self addOptBool(self.magicBullets, "启用魔法子弹", &magicbullets);
            self addOpt("Minigun", &changeBulletType, 0);
            self addOpt("Ballistic Knife", &changeBulletType, 1);
            self addOpt("Hellion Salvo", &changeBulletType, 2);
            if(BO4GetMap() == "Blood" || BO4GetMap() == "AO" || BO4GetMap() == "Tag" || BO4GetMap() == "Classified"){
            self addOpt("Ray Gun", &changeBulletType, 3);
        }    
        break;
        case "Pack a Punch Effects":
            self addMenu(menu, "强化效果");
            self addOpt("腐烂大脑", &acquireaat, "zm_aat_brain_decay");
            self addOpt("烈焰爆发", &acquireaat, "zm_aat_plasmatic_burst");
            self addOpt("电击杀手", &acquireaat, "zm_aat_kill_o_watt");
            self addOpt("冰冻", &acquireaat, "zm_aat_frostbite");
            self addOpt("移除效果", &RemoveEff);
        break;
        case "Camo Selector":
        self addMenu(menu, "选择迷彩");
            for(a=0;a<96;a++)
                    self addOpt("迷彩：" + (a + 1), &bo4_CamoGiver, a);
        break;
        case "Normal Weapons and items":
            self addMenu(menu, "普通武器和道具");
            for(z=0;z<level._WeaponCategs.size;z++)
                self addOpt(level._WeaponCategs[z], &newMenu, level._WeaponCategs2[z]);
        break;
        case "Assault Rifles":
            self addMenu(menu, "突击步枪");
            for(t=0;t<level._AssaultNames.size;t++)
                self addOpt("获得 "+level._AssaultNames[t], &GiveClientWeapon, level._AssaultStrings[t], self);
        break;
        case "SMG":
            self addMenu(menu, "冲锋枪");
            for(t=0;t<level._SMGNames.size;t++)
                self addOpt("获得 "+level._SMGNames[t], &GiveClientWeapon, level._SMGStrings[t], self);
        break;
        case "Tactical Rifles":
            self addMenu(menu, "战术步枪");
            for(t=0;t<level._TacticalNames.size;t++)
                self addOpt("获得 "+level._TacticalNames[t], &GiveClientWeapon, level._TacticalStrings[t], self);
        break;
        case "LMG":
            self addMenu(menu, "轻机枪");
            for(t=0;t<level._LMGNames.size;t++)
                self addOpt("获得 "+level._LMGNames[t], &GiveClientWeapon, level._LMGStrings[t], self);
        break;
        case "Sniper Rifles":
            self addMenu(menu, "狙击步枪");
            for(t=0;t<level._SniperNames.size;t++)
                self addOpt(level._SniperNames[t], &GiveClientWeapon, level._SniperStrings[t], self);
        break;
        case "Pistols":
            self addMenu(menu, "手枪");
            for(t = 0; t < level._PistolStrings.size; t++)
                self addOpt("获得 " + level._PistolNames[t], &GiveClientWeapon, level._PistolStrings[t], self);
        break;
        case "Shotguns":
            self addMenu(menu, "霰弹枪");
            for(t = 0; t < level._ShotgunStrings.size; t++)
                self addOpt("获得 " + level._ShotgunNames[t], &GiveClientWeapon, level._ShotgunStrings[t], self);
        break;
        case "Special Weapons":
            self addMenu(menu, "特殊武器");
             for(t = 0; t < level._SpecialStrings.size; t++)
                self addOpt(level._SpecialNames[t], &GiveClientWeapon, level._SpecialStrings[t], self);
                            switch(BO4GetMap())
            {
                case "Blood":
                case "AO":
                case "Tag":
                case "Classified": for(r=0;r<level._MapWeapsAether.size;r++) self addOpt(level._MapWeapsAetherNames[r],&GiveClientWeapon,level._MapWeapsAether[r],self);
                    break;
                case "Voyage":
                case "Dead":
                case "IX":
                case "AE": self addOpt("Homunculus", &GiveClientWeapon, "homunculus", self);//Credit SirCryptic / Abomination Unofficial
                break;
                }
        break;
        case "Map Specific Weapons and items":
            self addMenu(menu, "地图专属武器和道具");
            switch(BO4GetMap()){
                case "Voyage": for(t=0;t<level._VoyageWeapNames.size;t++)
                    self addOpt(level._VoyageWeapNames[t], &GiveClientWeapon,level._VoyageWeaps[t],self);
                    break;
                case "Blood": for(t=0;t<level._BloodWeaps.size;t++)
                    self addOpt(level._BloodWeapNames[t], &GiveClientWeapon, level._BloodWeaps[t],self);
                    break;
                case "IX": for(t=0;t<level._IXWeapNames.size;t++)
                    self addOpt(level._IXWeapNames[t], &GiveClientWeapon, level._IXWeaps[t], self);
                    break;
                case "Dead": for(t=0;t<level._DeadWeapNames.size;t++)
                    self addOpt(level._DeadWeapNames[t], &GiveClientWeapon, level._DeadWeaps[t], self);
                    break;
                case "AE": for(t=0;t<level._AEWeapNames.size;t++)
                    self addOpt(level._AEWeapNames[t], &GiveClientWeapon, level._AEWeaps[t], self);
                    break;
                case "Tag": for(t=0;t<level._TagWeapNames.size;t++)
                    self addOpt(level._TagWeapNames[t], &GiveClientWeapon, level._TagWeaps[t], self);
                    break;
                case "AO": for(t=0;t<level._AOWeapNames.size;t++)
                    self addOpt(level._AOWeapNames[t], &GiveClientWeapon, level._AOWeaps[t], self);
                    break;
                case "Classified": for(t=0;t<level._ClassWeapNames.size;t++)
                    self addOpt(level._ClassWeapNames[t], &GiveClientWeapon, level._ClassWeaps[t], self);
                    break;
            }
        break;
        case "Upgraded Weapons":
            self addMenu(menu, "强化武器");
            for(t=0;t<level._WeaponCategs.size - 1;t++)
                self addOpt(level._WeaponCategs[t], &newMenu, level._WeaponCategs3[t]);
        break;
        case "Upgraded AR":
            self addMenu(menu, "强化突击步枪");
            for(t=0;t<level._UpgAssaultNames.size;t++)
                self addOpt("获得 "+level._UpgAssaultNames[t], &GiveClientWeapon, level._AssaultStrings[t]+"_upgraded", self);
        break;
        case "Upgraded SMG":
            self addMenu(menu, "强化冲锋枪");
            for(z=0;z<level._UpgSMGNames.size;z++)
                self addOpt(level._UpgSMGNames[z], &GiveClientWeapon, level._SMGStrings[z]+"_upgraded", self);
        break;
            
        case "Upgraded TR":
            self addMenu(menu, "强化战术步枪");
            for(z=0;z<level._UpgTacticalNames.size;z++)
                self addOpt(level._UpgTacticalNames[z], &GiveClientWeapon, level._TacticalStrings[z]+"_upgraded", self);
        break;
        case "Upgraded LMG":
            self addMenu(menu, "强化轻机枪");
            for(z=0;z<level._UpgLMGNames.size;z++)
                self addOpt(level._UpgLMGNames[z], &GiveClientWeapon, level._LMGStrings[z]+"_upgraded", self);
        break;
        case "Upgraded SR":
            self addMenu(menu, "强化狙击步枪");
            for(t=0;t<level._UpgSniperNames.size;t++)
                self addOpt(level._UpgSniperNames[t], &GiveClientWeapon, level._SniperStrings[t]+"_upgraded", self);
        break;
        case "Upgraded Pistols":
            self addMenu(menu, "强化手枪");
           for(z=0;z<level._UpgPistolNames.size;z++)
                self addOpt(level._UpgPistolNames[z], &GiveClientWeapon, level._PistolStrings[z]+"_upgraded", self);
        break;
        case "Upgraded Shotguns":
            self addMenu(menu, "强化霰弹枪");
           for(z=0;z<level._UpgShotgunNames.size;z++)
                self addOpt(level._UpgShotgunNames[z], &GiveClientWeapon, level._ShotgunStrings[z]+"_upgraded", self);
        break;
        case "Upgraded Specials":
            self addMenu(menu, "强化特殊武器");
            for(t=0;t<level._UpgSpecialNames.size;t++)
                self addOpt(level._UpgSpecialNames[t],&GiveClientWeapon,level._UpgSpecialStrings[t],self);
            switch(BO4GetMap()){
                case "Voyage":
                    for(z=0;z<level._VoyageWeaps.size - 1;z++)
                        self addOpt(level._VoyageWeapNames[z], &GiveClientWeapon, level._VoyageWeaps[z]+"_upgraded", self);
                    self addOpt("Svalinn Guard", &GiveSvalinnGuard);
                break;
                case "Blood":
                    for(z=0;z<level._UpgBloodNames.size;z++)
                        self addOpt(level._UpgBloodNames[z], &GiveClientWeapon, level._UpgBloodWeaps[z], self);
                    for(r=0;r<level._MapWeapsAether.size - 1;r++) 
                        self addOpt(level._UpgMapWeapsAetherNames[r],&GiveClientWeapon,level._MapWeapsAether[r]+"_upgraded",self);
                break;
                case "AE":
                    for(z=0;z<level._AEWeaps.size - 2;z++)
                        self addOpt(level._AEWeapNames[z], &GiveClientWeapon, level._AEWeaps[z]+"_upgraded",self);
                break;
                case "Tag":
                    for(z=0;z<level._UpgTagWeapNames.size;z++)
                        self addOpt(level._UpgTagWeapNames[z], &GiveClientWeapon, level._UpgTagWeaps[z], self);
                    for(r=0;r<level._MapWeapsAether.size - 1;r++) 
                        self addOpt(level._UpgMapWeapsAetherNames[r],&GiveClientWeapon,level._MapWeapsAether[r]+"_upgraded",self);
                break;
                case "AO":
                    for(z=0;z<level._UpgAOWeaps.size - 2;z++)
                        self addOpt(level._AOWeapNames[z],&GiveClientWeapon, level._UpgAOWeaps[z],self);
                    for(r=0;r<level._MapWeapsAether.size - 1;r++) 
                        self addOpt(level._UpgMapWeapsAetherNames[r],&GiveClientWeapon,level._MapWeapsAether[r]+"_upgraded",self);
                break;
                case "Classified": 
                    for(z=0;z<level._UpgClassWeaps.size;z++)
                        self addOpt(level._UpgClassWeapNames[z], &GiveClientWeapon, level._UpgClassWeaps[z]+"_upgraded", self);
                    for(r=0;r<level._MapWeapsAether.size - 1;r++) 
                        self addOpt(level._UpgMapWeapsAetherNames[r],&GiveClientWeapon,level._MapWeapsAether[r]+"_upgraded",self);
                break;
                case "IX":
                    for(z=0;z<level._IXUpgNames.size;z++)
                        self addOpt(level._IXUpgNames[z], &GiveClientWeapon, level._IXWeaps[z]+"_upgraded", self);
                break;
                case "Dead":
                    for(z=0;z<level._DeadUpgWeaps.size;z++)
                        self addOpt(level._DeadUpgNames[z], &GiveClientWeapon, level._DeadUpgWeaps[z], self);
                break;
            }
        break;
        case "Powerups Menu":
            self addMenu(menu, "掉落物");
            if(BO4GetMap() == "Blood"){self addOpt("僵尸血", &GivePowerup, "zombie_blood");}
            for(t = 0; t < level._PowerupStrings.size; t++)
                self addOpt(level._PowerupNames[t], &GivePowerup, level._PowerupStrings[t]);
            break;

        case "Zombie Menu":
            self addMenu(menu, "僵尸功能");
            self addOpt("消灭全部僵尸", &KillAllZombies);
            self addOptIncSlider("修改回合：", &RoundEdit, 0, 0, 9999, 1);
            self addOptBool(self.ZombiePos, "持续传送到准星", &StartZombiePosistion);
            self addOptBool(self.NoTarg, "僵尸无视玩家", &notarget);
            self addOptBool(self.personal_instakill, "一击必杀", &selfInstaKill);
        break;

        case "Mystery Box Menu":
            self addMenu(menu, "神秘箱");
            self addOpt("价格设置", &newMenu, "Price Menu");
            self addOpt("传送到神秘箱", &TpToChest);
            self addOpt("固定神秘箱位置", &BO4FreezeBox);
            self addOpt("显示全部神秘箱", &ShowAllBoxes);
        break;

        case "Price Menu":
            self addMenu(menu, "神秘箱价格");
            self addOpt("默认价格：950", &BoxPrice, 950);
            self addOpt("免费", &BoxPrice, 0);
            self addOpt("价格：10", &BoxPrice, 10);
            self addOpt("价格：69", &BoxPrice, 69);
            self addOpt("价格：420", &BoxPrice, 420);
            self addOpt("价格：-1000", &BoxPrice, -1000);
            self addOpt("随机价格", &BoxPrice, randomIntRange(0, 999999));
        break;

        case "Account Menu":
            self addMenu(menu,"账号功能");
            self addOpt("设为最高等级", &BO4Level55, self);
            self addOpt("等级 1000（可能无效）", &BO4Level1000, self);
            self addOptBool(self.PlasmaLoop, "循环获得等离子", &PlasmaLoopplayer, self);
            self addOpt("完成当前合约", &CompleteActiveContracts, self);
            self addOpt("解锁全部内容", &bo4_UnlockAll, self);
            self addOpt("武器等级全满", &bo4_MaxLevels, self);
            self addOpt("解锁全部成就", &Achievements, self);
            self addOpt("统计数据", &newMenu, "Stats Menu");
        break;
        case "Stats Menu":
            self addMenu(menu,"统计数据");
            for(t=0;t<level._StatOpts.size;t++)
                self addOptIncSlider(level._StatOpts[t], &StatEditor, 0,0,10000,100,t);
        break;
        case "AllClient":
            self addMenu(menu, "全体玩家功能");
                self addOpt("全体无敌", &ClientFuncs, 0, undefined);
                self addOpt("全体无限弹药", &ClientFuncs, 1, undefined);
                self addOpt("全体最大点数", &ClientFuncs, 2, undefined);
                self addOpt("全体获得全部技能", &ClientFuncs, 3, undefined);
                self addOptIncSlider("自救次数", &SetSelfRevives, 0, 0, 125, 5);
        break;
        case "GameModes":
            self addMenu(menu, "游戏模式");
                self addOpt("全部武器轮换", &GameModeHandler, "All The Weapons");
                self addOpt("枪械游戏", &GameModeHandler, "Gun Game");
        break;
        case "Host Menu":
            self addMenu(menu, "房主功能");
                self addOptBool(level.Modvars, "切换 Mod 参数", &ModvarTest);
                self addOpt("选择地图", &newMenu, "Map Selection");
                self addOpt("正常结束游戏（保存统计）", &SafeEndGame);
                self addOpt("直接退出地图（不保存）", &PlayerExitLevel);
                self addOptIncSlider("设置经验倍率", &SetCustomXPMultiplier,0,0,100,1);
                self addOpt("开启武器强化机", &ActivatePAP);
                self addOpt("重新开始地图", &RestartMap);
            break;
        case "Players":
            self addMenu(menu, "玩家管理");
                foreach(player in level.players)
                {
                    if(!isDefined(player.playerSetting["verification"]))
                        player.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
                    
                    self addOpt("[^5" + player.playerSetting["verification"] + "^6]" + player getName(), &newMenu, "Options " + player GetEntityNumber());
                }
            break;
        default:
            foundplayer = false;
            for(a=0;a<level.players.size;a++)
            {
                sepmenu = StrTok(menu, " ");
                if(int(sepmenu[(sepmenu.size - 1)]) == level.players[a] GetEntityNumber())
                {
                    foundplayer = true;
                    self MenuOptionsPlayer(menu, level.players[a]);
                }
            }
            
            if(!foundplayer)
            {
                self addMenu(menu, "错误");
                    self addOpt("页面不存在");
            }
            break;
    }
}

MenuOptionsPlayer(menu, player)
{
    self endon("disconnect");
    
    sepmenu = StrTok(menu, " " + player GetEntityNumber());
    newmenu = "";
    for(a=0;a<sepmenu.size;a++)
    {
        newmenu += sepmenu[a];
        if(a != (sepmenu.size - 1))
            newmenu += " ";
    }
    
    switch(newmenu)
    {
        case "Options":       
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("权限设置", &newMenu, "Verification " + player GetEntityNumber());
                self addOpt("个人功能", &newMenu, "ClientPMods " + player GetEntityNumber());
                self addOpt("统计修改", &newMenu, "ClientStats " + player GetEntityNumber());
                self addOpt("恶搞功能", &newMenu, "Trolling " + player GetEntityNumber());
            break;
        case "Verification":
            self addMenu(menu, "权限设置");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
            break;
        case "ClientPMods":
            self addMenu(menu, "个人功能");
                self addOptBool(player.godmode, "无敌模式", &ClientHandler, 0, player);
                self addOptBool(player.betterUnlimitedAmmo, "无限弹药", &ClientHandler, 1, player);
                self addOpt("获得全部技能", &ClientHandler, 4, player);
                self addOpt("增加自救次数", &ClientHandler, 5, player);
                self addOpt("传送到该玩家", &TeleTo, 1,player);
                self addOpt("将该玩家传送过来", &TeleTo, 0,player);
                self addOpt("设为最大点数", &ClientHandler, 8, player);
                if (BO4GetMap() == "Blood"){self addOpt("给予 Blundergat", &GiveClientWeapon, "ww_blundergat_t8", player); self addOpt("给予 Magmagat", &GiveClientWeapon, "ww_blundergat_fire_t8", player); self addOpt("给予 AcidGat", &GiveClientWeapon, "ww_blundergat_acid_t8", player);}
        break;
        case "ClientStats":
            self addMenu(menu, "统计修改");
                self addOpt("设为最高等级", &ClientHandler, 2, player);
                self addOptBool(player.PlasmaLoop2, "循环获得 100 万等离子", &ClientHandler, 3, player);
                self addOpt("武器等级全满", &ClientHandler, 7, player);
                self addOpt("解锁全部内容", &ClientHandler, 6, player);
        break;
        case "Trolling":
            self addMenu(menu, "恶搞功能");
                self addOpt("移除全部武器", &TakeAllPlayerWeaps, player);
                self addOpt("清空玩家点数", &ClientHandler, 9, player);
                self addOpt("送入监狱", &sendToJail, player);
                self addOpt("击杀玩家", &KillPlayer, player);
                self addOpt("击倒玩家", &DownPlayer, player);
                self addOptIncSlider("发送消息", &PlayerMessage, 0,0,4,1, player);
            break;
        default:
            self addMenu(menu, "错误");
                self addOpt("页面不存在");
            break;
    }
}

menuMonitor()
{
    self endon("disconnect");
    
    while(true)
    {
        if(self getVerification() > 0)
        {
            if(!self isInMenu())
            {
                if(self AdsButtonPressed() && self MeleeButtonPressed() && !isDefined(self.menu["DisableMenuControls"]))
                {
                    if(isDefined(self.menu["currentMenu"]) && self.menu["currentMenu"] != "")
                        menu = self.menu["currentMenu"];
                    else
                        menu = "Main";
                    
                    self openMenu1(menu);
                    wait .25;
                }
            }
            else if(self isInMenu() && !isDefined(self.menu["DisableMenuControls"]))
            {
                if(self AdsButtonPressed() || self AttackButtonPressed())
                {
                    if(!self AdsButtonPressed() || !self AttackButtonPressed())
                    {
                        curs = self getCursor();
                        menu = self getCurrent();
                        
                        self.menu["curs"][menu] += self AttackButtonPressed();
                        self.menu["curs"][menu] -= self AdsButtonPressed();
                        
                        arry = self.menu["items"][self getCurrent()].name;
                        curs = self getCursor();

                        if(curs < 0 || curs > (arry.size - 1))
                            self setCursor((curs < 0) ? (arry.size - 1) : 0);

                        self drawText();
                        wait .13;
                    }
                }
                else if(self UseButtonPressed())
                {
                    menu = self getCurrent();
                    curs = self getCursor();
                    
                    if(isDefined(self.menu["items"][menu].func[curs]))
                    {
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], isDefined(self.menu["items"][menu].slider[curs]) ? self.menu_S[menu][curs][self.menu_SS[menu][curs]] : int(self.menu_SS[menu][curs]), self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        else
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        if(isDefined(isDefined(self.menu["items"][menu].bool[curs])))
                            self RefreshMenu();
                        wait .25;
                    }
                }
                else if(self SecondaryOffhandButtonPressed() || self FragButtonPressed())
                {
                    if(!self SecondaryOffhandButtonPressed() || !self FragButtonPressed())
                    {
                        menu = self getCurrent();
                        curs = self getCursor();
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                        {
                            inc = isDefined(self.menu["items"][menu].incslider[curs]) ? self.menu["items"][menu].intincrement[curs] : 1;
                            self.menu_SS[menu][curs] += self FragButtonPressed() ? inc : (inc * -1);
                            
                            if(isDefined(self.menu["items"][menu].slider[curs]))
                                self SetSlider(self.menu_SS[menu][curs]);
                            else
                                self SetIncSlider(self.menu_SS[menu][curs]);
                            self RefreshMenu();
                            wait .15;
                        }
                    }
                }
                else if(self MeleeButtonPressed())
                {
                    if(self getCurrent() == "Main")
                        self closeMenu1();
                    else
                        self newMenu();
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

ExecuteFunction(function, i1, i2, i3, i4, i5, i6)
{
    if(!isDefined(function))
        return;
    
    if(isDefined(i6))
        return self thread [[ function ]](i1, i2, i3, i4, i5, i6);
    if(isDefined(i5))
        return self thread [[ function ]](i1, i2, i3, i4, i5);
    if(isDefined(i4))
        return self thread [[ function ]](i1, i2, i3, i4);
    if(isDefined(i3))
        return self thread [[ function ]](i1, i2, i3);
    if(isDefined(i2))
        return self thread [[ function ]](i1, i2);
    if(isDefined(i1))
        return self thread [[ function ]](i1);
    
    return self thread [[ function ]]();
}
drawText()
{
    self endon("menuClosed");
    self endon("disconnect");

    if(!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;

    menu = self getCurrent();
    text = self.menu["items"][self getCurrent()].name;
    curs = self getCursor();
    start = 0;

    if (curs > 2 && curs < (text.size - 3) && text.size > 5)
        start = curs - 2;
    if (curs > (text.size - 4) && text.size > 5)
        start = text.size - 5;

    if(text.size > 0)
    {
        if(isDefined(self.menu["items"][menu].title))
            self iPrintlnBold("^3[ " + self.menu["items"][menu].title + " ]");
        self.lastRefresh = getTime();

        numOpts = text.size;
        if(numOpts >= 5)
            numOpts = 5;
        
        for(a=0;a<numOpts;a++)
        {
            text = self.menu["items"][menu].name;
            str = text[(a + start)];
            if(isDefined(self.menu["items"][menu].bool[(a + start)]))
                str += (isDefined(self.menu_B[menu][(a + start)]) && self.menu_B[menu][(a + start)]) ? " ^2[开]" : " ^1[关]";
            else if(isDefined(self.menu["items"][menu].incslider[(a + start)]))
                str += "^1 < " + self.menu_SS[menu][(a + start)] + " >";
            else if(isDefined(self.menu["items"][menu].slider[(a + start)]))
                str += " < " + self.menu_S[menu][(a + start)][self.menu_SS[menu][(a + start)]] + " >";
            
            if(curs == (a + start))
                self iPrintlnBold("^2   -> " + str + " ^0<-");
            else
                self iPrintlnBold("^." + str);
        }

        if(numOpts < 5)
        {
            printSize = 5 - numOpts;
            for(a=0;a<printSize;a++)
                self iPrintlnBold(".");
        }
    }
}

RefreshMenu()
{
    if(self hasMenu() && self isInMenu())
    {
        self runMenuIndex(self getCurrent());
        self drawText();
    }
}


openMenu1(menu)
{
    if(!isDefined(menu))
        menu = "Main";

    if(!isDefined(self.menu["curs"][menu]))
        self.menu["curs"][menu] = 0;
    

    self.menu["currentMenu"] = menu;
    self runMenuIndex(menu);
    self.playerSetting["isInMenu"] = true;
    self thread MonitorMenuRefresh();
}

MonitorMenuRefresh()
{
    self endon("disconnect");
    self endon("menuClosed");

    if(self isInMenu())
    {
        self drawText();
        while(self isInMenu())
        {
            if(self.lastRefresh < GetTime() - 3000)
                self drawText();
            wait 1;
        }
    }
}

closeMenu1()
{
    self DestroyOpts();
    self notify("menuClosed");
    self.playerSetting["isInMenu"] = undefined;
}

DestroyOpts()
{
    for(a=0;a<6;a++)
        self iPrintlnBold(".");
}
