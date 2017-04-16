# このリポジトリについて
Dockerファイルのテンプレートをまとめたリポジトリです。
アプリケーションの構成ごとディレクトリを分けてDockerファイルを管理しています。

# TIPS

```
# docker volumeの確認
docker volume ls

# docker volumeの削除
docker volume rm $VOLUME_NAME

# docker volumeの全削除(コンテナを停止させてからvolumeを削除する)
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker volume rm $(docker volume ls -q)

# コンテナから参照されていないvolumeの削除
docker volume rm $(docker volume ls -q -f dangling=true)
```
