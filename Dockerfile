# syntax=docker/dockerfile:1
FROM python:3.7-alpine
WORKDIR /code

# flask コマンドが使う環境変数を指定
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# gcc と他の依存関係をインストール
RUN apk add --no-cache gcc musl-dev linux-headers

# requirements.txt をコピーし、Python 依存関係をインストール
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# コンテナがポート 5000 をリッスンするよう、イメージに対してメタデータの記述を追加
EXPOSE 5000

# プロジェクト内にある現在のディレクトリ . を、イメージ内の 作業ディレクトリworkdir . にコピー
COPY . .

# コンテナ実行時のデフォルト コマンド flask run を指定
CMD ["flask", "run"]
