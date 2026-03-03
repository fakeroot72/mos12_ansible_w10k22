#include <unistd.h>

int main(){
	setuid(geteuid());
	char *const args = {NULL};
	return execv("/opt/.lycu1580v2/bin/usb_key_check.sh", &args);
}
