#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QProcess>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/board.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
