#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <gameutils.h>
#include<iostream>

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");
    QQmlApplicationEngine engine;
    qmlRegisterSingletonType(
                QUrl(QStringLiteral("qrc:/src/qml/GlobalVariables.qml")),
                "Global", 1, 0, "Global" );
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/board.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
