import QtTest 1.0
import QtQuick 2.0
import Qt5Mozilla 1.0
import "../../shared/componentCreation.js" as MyScript
import "../../shared/sharedTests.js" as SharedTests

Item {
    id: appWindow
    width: 480
    height: 800
    focus: true

    property bool mozViewInitialized
    property int scrollX
    property int scrollY

    QmlMozContext {
        id: mozContext
    }
    Connections {
        target: mozContext.instance
        onOnInitialized: {
            mozContext.instance.addComponentManifest(mozContext.getenv("QTTESTSROOT") + "/components/TestHelpers.manifest");
        }
    }

    QmlMozView {
        id: webViewport
        visible: true
        focus: true
        active: true
        anchors.fill: parent

        onViewInitialized: appWindow.mozViewInitialized = true
        onHandleSingleTap: {
            appWindow.clickX = point.x
            appWindow.clickY = point.y
        }
        onViewAreaChanged: {
            print("onViewAreaChanged: ", webViewport.scrollableOffset.x, webViewport.scrollableOffset.y);
            var offset = webViewport.scrollableOffset
            appWindow.scrollX = offset.x
            appWindow.scrollY = offset.y
        }
    }

    resources: TestCase {
        id: testcaseid
        name: "mozContextPage"
        when: windowShown
        parent: appWindow

        function cleanup() {
            mozContext.dumpTS("tst_scrolltest cleanup")
        }

        function test_TestScrollPaintOperations()
        {
            SharedTests.shared_TestScrollPaintOperations()
        }
    }
}
