# 準備

## 雛形の作成

```
# アプリのディレクトリへ移動
cd rails-docker-strater

# ファイルのコピー
./init.sh /path/to/application
-> docker-compose.dev.yml, Dockerfile.dev, .env.dev, database.ymlがコピーされる

# Gemfileの作成
echo "source 'https://rubygems.org'\ngem 'rails', '5.0.0.1'"> Gemfile

# イメージの構築
docker-compose build

# docker volumeの確認
docker volume ls
-> bundleとdbのvolumeが作成されていることを確認

# railsの雛形作成
docker-compose run --rm web bundle exec rails new . --force --database=postgresql --skip-bundle　-d

# プロセス確認
docker ps
-> dbのプロセスが立ち上がっていることを確認

# databaseのconfigの編集
vi config/database.yml
-> database.ymlをコピーする

# gitignoreのアップデート
echo "\n# Docker\n.env.dev" >> .gitignore

# datebase.ymlの設定に従って、データベースを作成する
docker-compose run web bundle exec rails db:create

```

## コンテナの作成

```
# イメージの再構築(Dockerfileに変更があった際に実行する)
docker-compose build

# コンテナを作成して起動する
docker-compose up -d

# コンテナ起動確認
docker ps
-> webとdbのプロセス実行されていることを確認

```

## 起動したコンテナにログイン

```
# webにログインする場合
docker exec -it $WEB_CONTAINER_NAME /bin/bash
例. docker exec -it railsdockerstarter_web_1 /bin/bash

# dbにログインする場合
docker exec -it $DB_CONTAINER_NAME /bin/bash
例. docker exec -it railsdockerstarter_db_1 /bin/bash

-> 以下、必要なコマンドをコンテナで実行する(「コマンド一覧」参考)

※コンテナにログインせずに直接コマンド実行したい場合、上記の/bin/bashの部分をコンテナで実行するコマンドに変更すればいい。
(例. docker exec -it railsdockerstrater_web_1 bundle exec rails db)
```

# コマンド一覧

## web

```
# railsを実行
bundle exec rails s -b 0.0.0.0

# コンソール
bundle exec rails c

# ログ確認
tail -f log/development.log

# テーブルの初期化
bundle exec rails db:migrate:reset

# seedデータの作成
bundle exec rails db:seed

```

## db

```
# postgresqlへの接続
psql -u $DB_USERNAME -D $DATABASE_NAME -p$DB_PASSWORD
例. psql -u root -D app_development -ppassword

```


# 既存のアプリをDocker化する場合

## 準備

```
# アプリのディレクトリへ移動
cd rails-docker-strater

# ファイルの作成
vi docker-compose.yml
-> docker-compose.dev.ymlの内容をコピー(dbのイメージのバージョンなどを確認する。)

vi Dockerfile
-> Dockerfile.devの内容をコピー

vi .env.dev
-> .env.devをコピー(DBの設定は適宜変更する)

echo "\n# Docker\n.env.dev" >> .gitignore

# config/database.ymlを変更
vi config/database.yml
-> database.ymlを参考に、以下のように変更する
##########
# username: <%= ENV.fetch('DB_USERNAME', 'root') %>
# password: <%= ENV.fetch('DB_PASSWORD', 'dummy') %>
# host:     <%= ENV.fetch('DB_HOST', 'db') %>
# database: <%= ENV.fetch('DB_NAME', 'dummy') %>
##########

# datebase.ymlの設定に従って、データベースを作成する
docker-compose run web bundle exec rails db:create

```
以下、「コンテナの作成」以降を参考
