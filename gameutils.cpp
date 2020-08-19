#include "gameutils.h"
#include<QJsonObject>
#include<QJsonDocument>
#include<QJsonValue>

bool GameUtils::save_game(QString path,
                           QJsonArray players,
                           QJsonObject board, QJsonObject info){

    QFile saveFile(path);

    if(!saveFile.open(QIODevice::WriteOnly)){
        qWarning("could'nt write file");
        return false;
    }
    QJsonObject game;
    game.insert("players", players);
    game.insert("board", board);
    game.insert("info", info);
    saveFile.write(QJsonDocument(game).toJson());
    return true;
}

bool GameUtils::load_game(QString path){
    QString val;
    QFile file;
    file.setFileName(path);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qWarning("Can't open this shit");
        return false;
    }

    val = file.readAll();
    file.close();

    QJsonDocument game_file = QJsonDocument::fromJson(val.toUtf8());

    QJsonObject game = game_file.object();
    setGame(game);

    return true;

}

GameUtils::GameUtils(QObject *parent) :
    QObject(parent)
{
}

QJsonObject GameUtils::game()
{


    return m_game;
}
#include<iostream>
void GameUtils::setGame(QJsonObject& game){
    if(game == m_game){
        return;
    }
    m_game = game;
    emit gameChanged();
}

bool GameUtils::new_game(){
    QFile saveFile("./newGame.json");
    if(!saveFile.open(QIODevice::WriteOnly)){
        qWarning("could'nt open save file");
        return false;
    }

    QJsonObject game;
    QJsonObject player1;
    player1.insert("name", "default_1");
    player1.insert("cl", "white");
    player1.insert("check", false);
    player1.insert("move_history", "[]");
    player1.insert("win_cnt", 0);
    player1.insert("lose_cnt", 0);
    player1.insert("draw_cnt", 0);
    QJsonObject player2 = player1;
    player2["name"] = "default_2";
    player2["cl"]= "black";
    QJsonArray players;
    players.insert(0, player1);
    players.insert(1, player2);

    QJsonObject info;
    info.insert("turn", 0);
    info.insert("start", "white");
    info.insert("type", "normal");
    info.insert("winner", "");



    QJsonArray board;

    game.insert("players" , players);
    game.insert("board", board);
    game.insert("info", info);
    saveFile.write(QJsonDocument(game).toJson());
    setGame(game);
    return true;
}


