 #!/bin/sh

veyon-cli authkeys delete teacher/private

veyon-cli authkeys import teacher/private teacher_private_key.pem

veyon-cli authkeys setaccessgroup teacher/private teacher

veyon-cli service restart

