#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QProcess>
#include<gameutils.h>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/board.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    GameUtils a;
    a.new_game();
    return app.exec();
}
