# mysql-workbench-on-docker

mysql-workbench-on-docker は、MySQL Workbench を Docker 内で動作させるためのスクリプトです。


## 動作環境

* x64, ARMv8 Linux 環境
* X サーバ (Wayland 環境の場合、XWayland など)
* Docker
* Docker Compose v2
* GNU Make


## 事前準備


### Docker イメージの作成

次のコマンドを利用します。

```sh
make docker-build
```


### ホスト側に必要なディレクトリを作成

次のコマンドを実行します。

```sh
make setup
```


### (オプション) デスクトップアイコンの作成

デスクトップ上に MySQL Workbench のアイコンを配置すると、素早く起動できます。

```sh
make icon
```

※ アイコン作成後にこのディレクトリを別の場所に移動させると動作しなくなります。


## 実行

デスクトップアイコンを使用せずに起動するには、次のコマンドを実行します。

```sh
make launch
```

MySQL Workbench を終了すると、自動で Docker コンテナが破棄されます。


## その他
* ファイルのインポート・エクスポート時など、必要に応じてマウントするディレクトリを追加してお使いください。
