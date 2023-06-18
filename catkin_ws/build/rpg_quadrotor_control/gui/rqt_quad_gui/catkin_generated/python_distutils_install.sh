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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/conor/catkin_ws/src/rpg_quadrotor_control/gui/rqt_quad_gui"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/conor/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/conor/catkin_ws/install/lib/python2.7/dist-packages:/home/conor/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/conor/catkin_ws/build" \
    "/usr/bin/python2" \
    "/home/conor/catkin_ws/src/rpg_quadrotor_control/gui/rqt_quad_gui/setup.py" \
     \
    build --build-base "/home/conor/catkin_ws/build/rpg_quadrotor_control/gui/rqt_quad_gui" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/conor/catkin_ws/install" --install-scripts="/home/conor/catkin_ws/install/bin"
