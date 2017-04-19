# 準備

## 雛形の作成

```
# アプリのディレクトリへ移動
cd rails-docker-starter

# ファイルのコピー
./init.sh /path/to/application
-> docker-compose.dev.yml, Dockerfile.devがコピーされる(リネームも合わせて行われる)

# Gemfileの作成
echo "source 'https://rubygems.org'\ngem 'rails', '5.0.0.1'"> Gemfile

# イメージの構築
docker-compose build

# railsの雛形作成
docker-compose run --rm web bundle exec rails new . --force --skip-bundle

# docker volumeの確認
docker volume ls
-> bundleのvolumeが作成されていることを確認

```

## コンテナの作成

```
# イメージの再構築(Dockerfileに変更があった際に実行する)
docker-compose build

# コンテナを作成して起動する
docker-compose up -d

# コンテナ起動確認
docker ps
-> webのプロセス実行されていることを確認
```

## 起動したコンテナにログイン

```
docker exec -it $WEB_CONTAINER_NAME /bin/bash
例. docker exec -it railsdockerstarter_web_1 /bin/bash
-> 以下、必要なコマンドをコンテナで実行する(「コマンド一覧」参考)

※コンテナにログインせずに直接コマンド実行したい場合、上記の/bin/bashの部分をコンテナで実行するコマンドに変更すればいい。
(例. docker exec -it railsdockerstrater_web_1 bundle exec rails db)
```

# コマンド一覧

```
# springのインストール
bundle exec spring binstub --all

# springのステータス
bin/spring status

# springの停止
bin/spring stop

# springを利用したrails(rake)コマンドの実行
bundle exec ***の代わりにbin/***を使うようにする

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

# sqlite3への接続
bundle exec rails db


```
