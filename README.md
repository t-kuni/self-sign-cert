# 自己署名証明書生成ツール

自己署名したサーバ証明書を生成するツールです。  
ドメイン名、IPアドレスを指定して生成できます。  
Subject Alternative Namesも設定するのでChromeでも利用できます。  
ローカル環境のサーバをHTTPS化する様な場合にご利用ください。  
  
なお、dockerを実行できる環境が必要です。

## リポジトリのクローン

```
git clone ssh://git@github.com/t-kuni/self-sign-cert 
cd self-sign-cert
```

## ビルド

```
docker build --tag self-sign-cert ./
```

## 実行

`HOST=xxx`でHTTPS化したいサーバのホスト名を指定してください  
`IP=xxx`でHTTPS化したいサーバのIPアドレスを指定してください  
この値が`Common Name`, `Subject Alternative Names`としてサーバ証明書に組み込まれます。  

```
docker run --rm -v $PWD/work:/work -e HOST=example.com -e IP=192.168.99.100 self-sign-cert
```

`work/out`ディレクトリに以下３つのファイルが生成されます。

* server.crt
    * サーバ証明書（コイツをサーバやクライアントに登録する必要があります）
* server.csr
    * 署名要求
* server.key
    * サーバ秘密鍵

## 証明書の内容を確認する

サーバ証明書の内容が気になる場合にどうぞ。

```
docker run --rm -v $PWD/work:/work self-sign-cert openssl x509 -in ./out/server.crt -text -noout
```

## サーバ証明書(server.crt)をサーバ、クライアントに組み込む

https://qiita.com/t-kuni/items/d3d72f429273cf0ee31e#nginx%E3%81%AE%E8%A8%AD%E5%AE%9A



## ペアチェック

[参考ドキュメント](https://qiita.com/sumida0713/items/72fcb2b0ab926c906507)

コマンドの実行結果(チェックサム値)が同じであれば、ペア(組み合わせ)が正しい。

SSL証明書

```
docker run --rm -v $PWD/work:/work self-sign-cert openssl x509 -noout -modulus -in ./out/server.crt | openssl md5
```

秘密鍵

```
docker run --rm -v $PWD/work:/work self-sign-cert openssl rsa -noout -modulus -in ./out/server.key | openssl md5
```

署名要求

```
docker run --rm -v $PWD/work:/work self-sign-cert openssl req -noout -modulus -in ./out/server.csr | openssl md5
```

## 最後に

お役にたてましたらスターを頂けると嬉しいです！！