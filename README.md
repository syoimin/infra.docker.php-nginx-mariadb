# 1 Docker 環境の構築
### 1.1 MacOSの方
Docker for Mac をインストール

### 1.2 vagrant + CentOS7 の方
OS バージョン：CentOS7.x  
Docker バージョン：18.06.1.ce-3.el7  
docker-compose バージョン：1.22.0  
参考：http://docs.docker.jp/engine/installation/linux/docker-ce/centos.html


#### 1.2.1 Docker をインストール
1. 古いバージョンのアンインストール  
`# yum remove docker docker-common docker-selinux docker-engine`  

2. 必要なパッケージをインストール  
`# yum install -y yum-utils device-mapper-persistent-data lvm2`

3. レポジトリの追加  
`# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`

4. パッケージインデックスを更新  
`# yum makecache fast`  

5. インストールバージョンの確認  
`# yum list docker-ce --showduplicates | sort -r`

6. Docker のインストール  
`# yum install docker-ce-<docker バージョン名>`  
例：`# yum install docker-ce-18.06.1.ce-3.el7`

7. Docker の起動  
`# systemctl start docker`  
`# systemctl enable docker`

8. Docker の確認  
`# docker run hello-world`  
下記内容が出力されればOK  

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
d1725b59e92d: Pull complete
Digest: sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788
Status: Downloaded newer image for hello-world:latest
 
Hello from Docker!
This message shows that your installation appears to be working correctly.
 
To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
 
To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash
 
Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/
 
For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

#### 1.2.2 docker-compose をインストール
1. cocker-compose のダウンロード  
`$ sudo curl -L "https://github.com/docker/compose/releases/download/<バージョン>/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

2. パスに実行権限を付与  
`$ sudo chmod +x /usr/local/bin/docker-compose`

3. バージョン確認  
`$ docker-compose --version`


#### 1.2.3 docker グループに所属
1. 下記コマンドで作業するユーザを docker グループに所属させてください  
`$ gpasswd -a <USER> docker`  

2. ログアウトし再ログインする  

※うまくいかない場合は下記を試してください。  
・/etc/group を直接編集してグループに追加  
・`$ gpasswd -a USER dockerroot` グループにも追加



## 3 注意事項
### 3.1 マウントしたフォルダの所有者が変(数値になる)
Linux 用の Docker を利用した場合起こる仕様です。Docker for Mac では起こりません。  
ホストサーバでファイルを修正する分には問題ないです。  
参考：https://qiita.com/yohm/items/047b2e68d008ebb0f001

### 3.2 コンテナ内で compose install, npm install した際にマウントされたホストディレクトリに root ユーザのファイル、フォルダができてしまう。
Linux 用の Docker を利用した場合起こる仕様です。Docker for Mac では起こりません。  
基本的に、コンテナ内で作成するファイルは compose install と npm install で作成したファイルのみの運用なので問題ありません。(other に 読み込み権限が付与されているので)  
composer と npm で作成された node_module, vendoer は手動で編集しないでください。  
そのほかの git で管理されているファイルは必ずホストサーバのファイルを編集してください。


## 4 その他
ホストボリュームにマウントされていない状態のイメージを確認したい場合
docker run -rm -it --name <コンテナ名> --env-file env.list <イメージ名>:latest
docker run -rm -it --name <コンテナ名> --env-file env.list <イメージ名>:latest 

