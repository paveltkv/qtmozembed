import QtTest 1.0
import QtQuick 2.0
import Qt5Mozilla 1.0
import "../../shared/componentCreation.js" as MyScript
import "../../shared/sharedTests.js" as SharedTests

Item {
    id: appWindow
    width: 480
    height: 800

    property bool mozViewInitialized
    property var mozView

    QmlMozContext {
        id: mozContext
    }

    resources: TestCase {
        id: testcaseid
        name: "mozContextPage"
        when: windowShown
        parent: appWindow

        function cleanup() {
            mozContext.dumpTS("tst_viewbasicapi cleanup")
        }

        function test_1contextPrepareViewContext()
        {
            SharedTests.shared_1contextPrepareViewContext()
        }
        function test_2viewInit()
        {
            mozContext.dumpTS("test_2viewInitBasic start")
            testcaseid.verify(mozContext.instance.initialized())
            MyScript.createSpriteObjects();
            while (mozView == null) {
                testcaseid.wait(500)
            }
            mozContext.dumpTS("test_2viewInitBasic start1")
            testcaseid.verify(MyScript.waitMozView())
            testcaseid.verify(mozView.uniqueID() > 0)
            testcaseid.verify(mozView.child)
            mozView = null
            mozContext.dumpTS("test_2viewInitBasic end")
        }
    }
}
