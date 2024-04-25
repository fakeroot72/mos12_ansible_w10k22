#!/bin/sh

# This is the command to change the desktop background on KDE plasma

while true
do 

sleep 5 && qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
    var allDesktops = desktops();
    for (i=0;i<allDesktops.length;i++) 
    {
        d = allDesktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
        d.writeConfig("Image", "file:///home/student/wallpaper.jpg")
    }
' && exit

done &
