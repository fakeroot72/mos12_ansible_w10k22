 #!/bin/sh

veyon-cli config clear

veyon-cli networkobjects clear

veyon-cli config set "Authentication/Method" 1

veyon-cli authkeys delete teacher/public

veyon-cli authkeys import teacher/public files/veyon/teacher_public_key.pem

veyon-cli authkeys setaccessgroup teacher/public teacher

for f in `ls files/veyon/networkobjects/*.mac?`
do
    echo files/veyon/networkobjects/$f
    veyon-cli networkobjects import files/veyon/networkobjects/$f location $f format "%name%;%mac%"
done

for f in `ls files/veyon/networkobjects/*.ip?`
do
    echo files/veyon/networkobjects/$f
    veyon-cli networkobjects import files/veyon/networkobjects/$f location $f format "%name%;%host%"
done

veyon-cli service restart

