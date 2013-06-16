#!/bin/sh

# Create a temporary DBus session to isolate us from the normal environment.
export `dbus-launch`
QMLMOZTESTRUNNER=/usr/lib/qt4/bin/qmlmoztestrunner
if [ "$QTTESTPATH" != "" ]; then
  QMLMOZTESTRUNNER=$QTTESTPATH/qmlmoztestrunner/qmlmoztestrunner
fi
export QTTESTPATH=${QTTESTPATH:-"/opt/tests/qtmozembed"}
export QML_IMPORT_PATH=$QTTESTPATH/imports
export QML2_IMPORT_PATH=$QTTESTPATH/imports

#export NSPR_LOG_MODULES=EmbedLiteTrace:5,EmbedNonImpl:5,EmbedLiteApp:5,EmbedLiteView:5,EmbedLiteViewThreadParent:5

$QMLMOZTESTRUNNER -opengl $@
exit_code=$?

kill $DBUS_SESSION_BUS_PID

exit $exit_code
