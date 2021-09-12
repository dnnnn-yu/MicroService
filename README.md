# ファイル保存用マイクロサービス

## 起動コマンド
~~~
$ bundle exec ruby bin/startup.rb
~~~

## 開発時の Docker での起動
~~~
$ docker build . -t microservice
$ docker run --mount type=bind,source=$(pwd),target=/app -p 3001:3001 -it microservice:latest bash
~~~

## ProtocolBuffer
~~~
$ bundle exec grpc_tools_ruby_protoc --ruby_out=lib --grpc_out=lib ./microservice.proto
~~~