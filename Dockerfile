# ベースとして使用するイメージ名（DockerHubからダウンロードされる）
FROM ruby:3.2.2-alpine
 
# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update
 
# パッケージをインストールするコマンドを実行
# M1 Macではnokogiriのビルドにbuild-baseが必要
RUN apk add g++ make mysql-dev tzdata build-base nodejs npm -y && \
    npm uninstall yarn -g && \
    npm install yarn -g -y
 
# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /app
 
# PC上のGemfile を .（/app）にコピー
COPY Gemfile .
 
# バイナリのgemではなく、ソースコードからgemをビルドする設定
RUN bundle config set force_ruby_platform true
 
# bundle installでGemfileに記述されているgemをインストール
RUN bundle install

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]