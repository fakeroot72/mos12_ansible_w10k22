#!/bin/sh

# This is the command to change the desktop background on KDE plasma

while true
do 

    if [ `hostname | grep 1580-4` ]
    then
        sleep 5 && qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
            var allDesktops = desktops();
            for (i=0;i<allDesktops.length;i++) 
            {
                d = allDesktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
                d.writeConfig("Image", "file:///opt/.lycu1580/files/wallpaper_001-warning.jpg")
            }
        ' && exit

    else

        sleep 5 && qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
            var allDesktops = desktops();
            for (i=0;i<allDesktops.length;i++) 
            {
                d = allDesktops[i];
                d.wallpaperPlugin = "org.kde.image";
                d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
                d.writeConfig("Image", "file:///opt/.lycu1580/files/wallpaper_1580-warning.jpg")
            }
        ' && exit

    fi

done &
