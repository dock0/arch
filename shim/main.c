#include <sys/stat.h>

int main() {
    chmod("/.ducktape", S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH);
    return 0;
}
