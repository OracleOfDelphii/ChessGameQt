#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<gameutils.h>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
qputenv("QT_QUICK_CONTROLS_STYLE", "material");
    QQmlApplicationEngine engine;
   qmlRegisterSingletonType( QUrl("qrc:/GlobalVariables.qml"),
                             "io.qt.examples.global", 1, 0, "Global" );
    engine.load(QUrl(QStringLiteral("qrc:/board.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    GameUtils a;

    return app.exec();
}
