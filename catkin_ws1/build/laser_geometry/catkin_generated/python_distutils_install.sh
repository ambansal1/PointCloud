#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/amit/catkin_ws1/src/laser_geometry"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/amit/catkin_ws1/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/amit/catkin_ws1/install/lib/python2.7/dist-packages:/home/amit/catkin_ws1/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/amit/catkin_ws1/build" \
    "/usr/bin/python" \
    "/home/amit/catkin_ws1/src/laser_geometry/setup.py" \
    build --build-base "/home/amit/catkin_ws1/build/laser_geometry" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/amit/catkin_ws1/install" --install-scripts="/home/amit/catkin_ws1/install/bin"
