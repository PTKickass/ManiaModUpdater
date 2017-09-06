## Sonic Mania Mod Updater (ManiaModUpdater)

ManiaModUpdater allows you to make your mods auto-updatable by simply adding one file and 2 links to your mod.ini file!



How to make your mod compatible with ManiaModUpdater:
- Add these lines to your existing mod.ini file so it looks like this (don't forget to remove the "()", since between that are only
commentaries and may render ManiaModUpdater unusable with your mod:
```
  [AUTO_UPDATER]

   --------------------------------------- (Leave these lines)

   UpdateServer_mod.ini_file=[PASTE BELOW]

   (Direct link for your newest mod.ini file. ManiaModUpdater uses this file to check if there's a newer version available.)

   UpdateServer_Changelog=[PASTE BELOW]

   (Direct link to your newest changelog. The tool uses this to... well... print the changelog when there's an update available, so make it look nice)
   
   UpdateServer_Update_File=[PASTE BELOW]

   (Direct link to the newest version of your mod. IT NEEDS TO BE IN .ZIP! It should be packed like this: https://goo.gl/g9iH7B)
```

- Create a new file called Mod_Updater.ini inside your mod folder, and paste this inside it:
```
[THIS FILE IS USED FOR UPDATE SUPPORT DETECTION AND FOR DEBUGGING PURPOSES]
[DO NOT DELETE]

IsUpdaterSupport=false
IsEnableDebug=false
```

- Your mod should now be ready to use and detectable by ManiaModUpdater!
