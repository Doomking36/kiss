KISS_PATH=/home/dk/repos/repo/core
KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/extra
KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/xorg
KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/community
KISS_PATH=$KISS_PATH:/home/dk/repos/repo/extra
KISS_PATH=$KISS_PATH:/home/dk/repos/repo/wayland
KISS_PATH=$KISS_PATH:/home/dk/repos/community/community
export KISS_PATH

# Build Flags
export CFLAGS="-march=native -Os"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j1"
export SAMUFLAGS="-j1"

# Set date and time
export TZ=CDT
