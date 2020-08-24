#ifndef SAVE_GAME_H
#define SAVE_GAME_H
#include<QString>
#include<QDir>
#include<QJsonArray>
#include <QObject>
#include <QString>
#include <qqml.h>
#include<QJsonObject>
#include<QJsonDocument>

class GameUtils: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject game READ game WRITE setGame NOTIFY gameChanged)
    QML_ELEMENT


public:
    explicit GameUtils(QObject* parent = nullptr);

    Q_INVOKABLE
    bool save_game(QString path,
                   QJsonArray players,
                   QJsonObject board, QJsonObject info);
    Q_INVOKABLE
    bool load_game(QString path);
    //  bool reset_game(QString path);
    //  void new_player(QString name);
    Q_INVOKABLE
    bool new_game();

    bool get_players();

    Q_INVOKABLE
    int add_to_all_players(QJsonObject player);

    Q_INVOKABLE
    bool update_high_score(QJsonObject game);






    void setGame(QJsonObject &game);
    QJsonObject game();


signals:
    void gameChanged();




private:
    bool load_json(QString path, QJsonObject &obj);
    bool save_json(QString path, QJsonObject &obj);
    QJsonObject m_game;
};

#endif // SAVE_GAME_H
