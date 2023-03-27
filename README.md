# ChatCLI

OpenAI APIを利用し、GPT-3.5-turboへ質問を投げかけることができるCLIアプリケーションです。  
※利用者自身のAPI Keyを使用して、OpenAI APIへリクエストを送ります。

## 推奨環境
- Mac (Intel)
- MacOS (Monterey v12.6.1)
- Ruby (2.6.10p210)
- Bundler (2.4.9)

## Installation

1. gemのインストール  
`gem install chat_cli`

## Usage

`$sudo chat_cli init`  
下記サイトで作成したシークレットAPIキーを記録します。  
https://platform.openai.com/account/api-keys

`$chat_cli chat {message}`   
GPT-3.5へメッセージを送ります。返答まで最大240秒待つ必要があり、これ以上返答に時間がかかる場合は返答を短くするような質問にしなければいけません。 

`$chat_cli usage`
現在のAPI利用量を下記サイトから閲覧することができます。   
https://platform.openai.com/account/usage

## Dependencies

利用したパッケージは以下の通りです
- [ruby-openai](https://github.com/alexrudall/ruby-openai)
- [thor](https://github.com/rails/thor)
- [dotenv](https://github.com/bkeepers/dotenv)
