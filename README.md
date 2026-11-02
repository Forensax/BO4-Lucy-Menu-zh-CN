# BO4 Lucy Menu 简体中文汉化

这是 [AuroraDoesCode/BO4-Lucy-Menu](https://github.com/AuroraDoesCode/BO4-Lucy-Menu) 的简体中文汉化 Fork，已同步至上游提交 `7b3bcd401fe1c286f44fa1c685f9324d4c7dbaae`。

- 菜单名称：`Lucy 菜单`
- 汉化版本：`1.5.0-zh-CN`
- 状态：已编译并静态验证，待游戏内显示验证
- 下载：[v1.5.0-zh-CN Release](https://github.com/Forensax/BO4-Lucy-Menu-zh-CN/releases/tag/v1.5.0-zh-CN)
- 一键注入包：[Lucy-Menu-zh-CN-OneClick-v1.5.0.zip](https://github.com/Forensax/BO4-Lucy-Menu-zh-CN/releases/download/v1.5.0-zh-CN/Lucy-Menu-zh-CN-OneClick-v1.5.0.zip)
- 详细说明：[汉化说明.md](./汉化说明.md)

菜单、权限、开关、提示、地图、传送地点、技能、药剂和掉落物等玩家可见文本已汉化。武器型号、升级武器名称、玩家名、作者名及内部资源标识保留原文。

使用时下载 Release 中的 `Lucy-Menu-zh-CN.gscc`，按照下方上游说明安装 [T7 Compiler](https://github.com/AuroraDoesCode/t7-compiler-custom) 和 [图形前端](https://github.com/AuroraDoesCode/Black-Ops-GSC-Compiler-Frontend)，通过 `Load Script` 加载脚本，选择 `ZOMBIES` 模式，再使用 `Inject GSCC` 注入。本项目没有进行游戏内注入测试；BO4 字体对中文字形的实际显示效果仍需实机确认。

中文源码需要支持 UTF-8 字符串表的 T8 编译器。Release 产物已经使用修改后的离线编译器完成编译和字符串表反读验证。原版 ASCII 字符串写入会将中文转换为问号。

一键包包含上述 Release 原始成品与注入工具，未重新编译。完整解压后，进入僵尸模式私人大厅，双击 `一键注入.cmd`。注入成功后保持窗口打开，游戏过程中不要按键；工具等待的任意键会重置脚本。需要 Windows 10/11 与 .NET Framework 4.8 或更高版本。

本地源码编译可运行 `powershell -NoProfile -ExecutionPolicy Bypass -File .\build-zh-CN.ps1`，通过 `-CompilerPath` 指定 UTF-8 修改版编译器。生成一键包可运行 `powershell -NoProfile -ExecutionPolicy Bypass -File .\package-oneclick.ps1 -PayloadPath "Release 原始 gscc 路径" -RuntimeDirectory "注入工具目录" -OutputDirectory "输出目录"`；打包前强制核对原始产物 SHA-256，输出 ZIP 和同名 `.sha256` 校验文件。

> 上游仓库当前未提供许可证文件。原项目及相关代码版权归原作者和贡献者所有，本仓库保留完整 Git 历史和 GitHub Fork 关系，仅提供简体中文本地化。菜单包含账号、统计、成就和永久解锁功能，使用前请备份数据并自行评估风险。

---

<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stars][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/TheUnknownCod3r/BO4-Lucy-Menu">
    <img src="images/logo.png" alt="Logo" width="300" height="300">
  </a>
  <h3 align="center">The Lucy Menu</h3>

  <p align="center">
	A Free, Open Source, Fully Maintained BO4 GSC Mod Menu for PC & PS4.<br>For Battle.net, Shield Client & Homebrew PS4 Consoles!
    <br />
	  <h1 align="center">Alternate Fork of T7 Compiler: https://github.com/AuroraDoesCode/t7-compiler-custom (Should work on BO3, BO4, and Cold War.)</h1>
    <a href="https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/issues">Report Bug</a>
    ·
    <a href="https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/issues">Request Feature</a>
	<br />
    <a href="https://github.com/TheUnknownCod3r/ColdWar-Lucy-Base/">Cold War Menu Base Port</a>
    ·
    <a href="https://github.com/TheUnknownCod3r/BO4-Lucy-MP-Base/">BO4 Multiplayer Menu Base Port</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
	  <li><a href="#changelog">Changelog</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>




### Prerequisites

To use this Mod Menu, ensure you have T7 Compiler installed, link above, and download the Frontend: https://github.com/AuroraDoesCode/Black-Ops-GSC-Compiler-Frontend
These Instructions Apply to BOTH Battle.net, and Shield Client.

<p align="right">(<a href="#top">back to top</a>)</p>



## Usage
Video Guide located [Here](https://www.youtube.com/watch?v=h_XE8kQIttc), or for a text guide, The following instructions can be used with ease.
	
	1. Download a Compiled Version of the Menu from Releases, and save it to your desktop.
	
	2. Download and Extract T8 Compiler GUI from https://github.com/AuroraDoesCode/Black-Ops-GSC-Compiler-Frontend, then open T8 Compiler GUI.

	3. Inside T8 Compiler GUI, hit Load Script, and load the Compiled.gscc you downloaded from the releases section. It will auto Populate on the right. Make sure the mode is "ZOMBIES"!
	
	4. Load Black Ops 4, Go into a Zombies private match Lobby, and Click "Inject GSCC". If successful, You will get a popup box telling you GSC Injected successfully.
	
	5. Once the game loads, You should be able to Aim and Knife to open the menu. Aim to Scroll Up, Shoot to Scroll Down. F To Select, Melee to go Back. For controllers, this is LT & RS to open, LT to Scroll Up, RT to scroll Down, X to Select, Melee go back.

	6. If an option has a Slider, you can use Smoke and Frag to navigate.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Full Map Completion of EE's
- [ ] Map Switch with character support
- [ ] More Game Modes, Model changer, More features
- [ ] Add Spawning Catalysts, Blightfathers, Stokers etc.


<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions by the community are welcome, as are Bug Fixes, and suggestions. If you have an idea You wanna make and add, here's how you can contribute!

1. Fork the Project
2. Create a new branch and in the name, add -add-yourchanges
3. Apply and test your changes
4. If no issues occur, Submit a Pull request, and we'll check everything before accepting!

<p align="right">(<a href="#top">back to top</a>)</p>

## Changelog

Version 1.5.0
<details>
	<summary>
		Version 1.5.0
	</summary>

	- Change Kills_Loaded to hash value, which doesnt error, fix #33 & others
	- Overhaul entire menu to look cleaner, function better, take up less resources overrall, and removed some useless things
	- Add Perk Selection Menu
	- Fix Unlock All on all maps other than Voyage, which worked as intended. Close #48 & #49
	- Various other code cleanups, to make future maintenance easier.
	- PS4 Support (Thanks Muzzman) <3
</details>

Version 1.4.8
<details>
	<summary>
		Version 1.4.8
	</summary>

	- Fix Missing Challenge in Unlock All Camos
	- Various changes.
</details>

Version 1.4.7
<details>
	<summary>
		Version 1.4.7
	</summary>
	
	- Fix Crash in Stat Menu
	- Custom XP Modifier
	- Extra Unlimited Ammo Function
	- Demi God Function
	- Clean menu Structure to make Future Maintenance Easier.
</details>

Version 1.4.6
<details>
	<summary>
		Version 1.4.6
	</summary>
	
	- More Weapon Stringnames
	- Re-add Open PAP
	- Give Weapons with Player Build Kits
	- Shaolin Shuffle inspired Kill Aura
	- Fixes and Improvements across the board
	- Update Hashes in Headers
	- More coming Soon!
</details>

Version 1.4.5
<details>
	<summary>
		Version 1.4.5
	</summary>

	- Updated Several Weapon Stringnames (Credit: @TubBuddy)
	- Unlock All Now actually unlocks all Camos correctly (Fixes #24)
</details>

Version 1.4.4
<details>
	<summary>
		Version 1.4.4
	</summary>

	- Added Bull Upgrade and EE Song 2, Credit @3P1CBOSS84 
	- Added Original names for the Death of Orion and Svalinn Guard, Credit @stabz47 @ate47 
</details>

Version 1.4.3
<details>
	<summary>
		Version 1.4.3
	</summary>

	- All Specialists added, Credit @tubBuddy
</details>

Version 1.4.2
<details>
	<summary>
		Version 1.4.2
	</summary>

	- All Guns Added, Credit @ate47
</details>

Version 1.4.1
<details>
	<summary>
		Version 1.4.1
	</summary>

	- Matryoshka Dolls added, Credit @TubBuddy
	- Pegasus Strike added
	- More guns added, Credit @TubBuddy
</details>

Version 1.4
<details>
	<summary>
		Version 1.4
	</summary>

	- Winters Howl, Death Of Orion, Wunderwaffe DG-Scharfschütze, Elemental Rayguns and Alistars Folly upgrades all added, Credit @TubBuddy
	- Upgraded Weapon Varients seperated , Credit @TubBuddy
	- All Shields added , Credit @TubBuddy
	- Bullet Menu Added
	- No Recoil Added
	- Samantha Box and Stake Knife added , Credit @TubBuddy
</details>

Version 1.3.4
<details>
	<summary>
		Version 1.3.4
	</summary>

	- Full Map Teleports, Credit @TubBuddy
	- Changed several Weapon stringnames, to the upgraded Variants instead. Will separate in future
</details>

Version 1.3.3
<details>
	<summary>
		Version 1.3.3
	</summary>

	- Added Teleports for Voyage, IX, Dead of the Night, and Ancient Evil, Thanks @TubBuddy
	- Fixed Tag Der Toten Map Weapons, Wonderwaffe is now correct, as is the Wonderwaffe Sniper
	- Added Homonculus, and Monkey bombs to All supported Maps
	- Fix a crash caused by Teleport Zombies to You, my Mistake.
	- No Clip, Finally. This will be changed, when I figure out why my script crashes XD.
</details>

Version 1.3
<details>
	<summary>
		Version 1.3
	</summary>
	
	- Added Gun Game and All The Weapons
	- Fixed a Rank up issue
	- Fixed a UI error with Open All Doors / Debris
	- Altered credits to reflect new Developer
	- Finished Elixir Menu
	- Started Map Specific Weapons
</details>

Version 1.2.3
<details>
	<summary>
		Version 1.2.3 Changes
	</summary>
	
	- Started Elixir Menu
	- Cleaned up Functions and Revamped Menu Struct
	- Added Map Selection and Teleport Menu
</details>

Version 1.2.2
<details>
	<summary>
		Version 1.2.2 Changes
	</summary>
	
	- Fix Weapons Menu
	- Fix Score Menu erroring on selection
	- Remove IX Limitation
	- Added PAP Effects Menu
</details>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

This wouldn't be possible without the following people

* [Shiversoft Dev](https://www.github.com/shiversoftdev/T7-compiler)
	without T7 Compiler, BO4 GSC Injection wouldn't be possible.

* [G1llam](https://www.github.com/G1llam/)
	Original Menu creator

* [TheUnknownCod3r](https://www.github.com/TheUnknownCod3r/)
	Taking over updates, Fixing/Maintaining and Porting new features.
	
* [SirCryptic](https://www.github.com/SirCryptic)
	Homunculus stringname, NoClip Function and Bullet Menu.
* [TubBuddy](https://www.github.com/TubBuddy/)
	Most of the Map Teleport Options, Wonder Weapons, Equipments And All Shields.
* [Ate47](https://github.com/ate47)
  	Updated Raw files I used for the menu, as well as the XP Modifier Initial code, and more.
* [Ori-Jakob](https://github.com/Ori-Jakob)
	Updated Unlimited Ammo, Demi God, and Score Only Increase Function
* [Jek47](https://www.github.com/Jek47/)
  	The GUI for T8 Compiler.
* [Muzzman](https://discord.gg/muzzman)
  	Compiled for PS4 and Tested.
* [ZombieSlayaMr](https://www.youtube.com/@zombieslayamr)
  Provided the video guide for code Injection

* several community members supplied the unhashed weapon names. 

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/TheUnknownCod3r/BO4-Lucy-Menu.svg?style=for-the-badge
[contributors-url]: https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/TheUnknownCod3r/BO4-Lucy-Menu.svg?style=for-the-badge
[forks-url]: https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/network/members
[stars-shield]: https://img.shields.io/github/stars/TheUnknownCod3r/BO4-Lucy-Menu.svg?style=for-the-badge
[stars-url]: https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/stargazers
[issues-shield]: https://img.shields.io/github/issues/TheUnknownCod3r/BO4-Lucy-Menu.svg?style=for-the-badge
[issues-url]: https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/issues
[license-shield]: https://img.shields.io/github/license/TheUnknownCod3r/BO4-Lucy-Menu.svg?style=for-the-badge
[license-url]: https://github.com/TheUnknownCod3r/BO4-Lucy-Menu/blob/master/LICENSE.txt
