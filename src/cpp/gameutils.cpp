#include "src/cpp/gameutils.h"
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

bool GameUtils::save_json(QString path, QJsonObject& obj){
    QFile saveFile(path);

    if(!saveFile.open(QIODevice::WriteOnly)){
        qWarning("could'nt write file");
        return false;
    }
    saveFile.write(QJsonDocument(obj).toJson());
    saveFile.close();
    return true;
}

bool GameUtils::load_json(QString path, QJsonObject &obj){
    QString val;
    QFile file;
    file.setFileName(path);

    if(!file.open(QIODevice::ReadWrite | QIODevice::Text)){
        qWarning("Can't open this shit");
        return false;
    }

    val = file.readAll();
    file.close();
    obj = QJsonDocument::fromJson(val.toUtf8()).object();
    return true;

}

bool GameUtils::load_game(QString path){
    QJsonObject game;
    load_json(path, game);
    setGame(game);

    return true;
}

GameUtils::GameUtils(QObject *parent):
    QObject(parent){
}

QJsonObject GameUtils::game(){
    return m_game;
}

void GameUtils::setGame(QJsonObject& game){
    if(game == m_game){
        return;
    }
    m_game = game;
    emit gameChanged();
}

bool GameUtils::new_game(){
    QString save_path = "./newGame.json";
    QJsonObject game = m_game;

    save_json(save_path, game);
    setGame(game);
    return true;
}

// It adds the a new player to the highscore
// If the player exists, returns 0
// If the file can't be retrieved, returns -1
int GameUtils::add_to_all_players(QJsonObject player){

    QString all_players_path = "./all_players.json";

    QJsonObject all_players;
    if(!load_json(all_players_path, all_players)){
        return -1;
    }

    QString name = player.value("name").toString();
    QJsonObject stats;
    stats.insert("win", player.value("win"));
    stats.insert("lose", player.value("lose"));
    stats.insert("draw", player.value("draw"));

    if(!all_players.contains(player.value("name").toString())){
        all_players.insert(name, stats);
        save_json(all_players_path, all_players);
        return 1;

    }

    return 0;
}

bool GameUtils::update_high_score(QJsonObject game)
{

    QString ranking_path = "./ranking.json";

    QJsonObject player1 = game.value("player1").toObject();
    QJsonObject player2 = game.value("player2").toObject();

    QJsonObject ranking;

    if(!load_json(ranking_path, ranking)){
        return false;
    }

    ranking.insert("player1", player1);
    ranking.insert("player2", player2);

     save_json(ranking_path, ranking);

    return true;
};
