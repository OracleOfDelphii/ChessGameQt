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
    QProcess process1;
    QProcess process2;

    process1.setStandardOutputProcess(&process2);



    return app.exec();
}
