#!/bin/sh

QTVER=5

# Create a temporary DBus session to isolate us from the normal environment.
export `dbus-launch`
if [ "$QTMOZEMBEDOBJDIR" != "" ]; then
  QMLMOZTESTRUNNER=$QTMOZEMBEDOBJDIR/tests/qmlmoztestrunner/qmlmoztestrunner
  export QML2_IMPORT_PATH=$QTMOZEMBEDOBJDIR/qmlplugin5
else
  QMLMOZTESTRUNNER=/opt/tests/qtmozembed/qmlmoztestrunner
  export QML_IMPORT_PATH=/opt/tests/qtmozembed/imports
fi
CURDIR=$PWD
export QTTESTSROOT=${QTTESTSROOT:-"/opt/tests/qtmozembed"}
if [ "$QTTESTSLOCATION" != "" ]; then
  cd $QTTESTSLOCATION
fi
export QTTESTSLOCATION=${QTTESTSLOCATION:-"/opt/tests/qtmozembed/auto/mer-qt$QTVER"}

# TODO: Get rid of this in tests see JB#?????
export GECKO_THREAD=1

#export NSPR_LOG_MODULES=EmbedLiteTrace:5,EmbedNonImpl:5,EmbedLiteApp:5,EmbedLiteView:5,EmbedLiteViewThreadParent:5

$QMLMOZTESTRUNNER -opengl $@
exit_code=$?
cd $CURDIR
kill $DBUS_SESSION_BUS_PID

exit $exit_code
