# frozen_string_literal: true

require 'thor'
require 'openai'
require 'dotenv/load'

require_relative "chat_cli/version"

module ChatCli
  class Error < StandardError; end
  
  class CLI < Thor
    LOADING_CHAR = ['\\', '-', '/', '|']

    desc("chat [MESSAGE]", "Sends a message to ChatGPT. ex) $chat_cli chat ペットにとっての優しい世界を実現するにはどうすれば良いでしょうか？")
    long_desc <<-LONGDESC
        `chat_cli chat [Message]` sends a message to ChatGPT and print its response.

        The model that made this response is `gpt-3.5-turbo-0301`.
        In addition, the timeout period for response is 240 seconds. 
        Messages that take longer than this to respond cannot be sent.

        ex)
        > $ chat_cli chat ペットにとっての優しい世界を実現するにはどうすれば良いでしょうか？
    LONGDESC
    def chat(question)
        Dotenv.load(File.expand_path("../.env", __dir__))
        token = ENV['OPENAI_ACCESS_TOKEN']
        if token.nil?
            say "The following command must be executed to set the secret API key.\n" \
            "> $sudo chat_cli init", :yellow
            return
        end
        client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
        response = nil
        thread = Thread.new {
            response = client.chat(
                parameters: {
                    model: "gpt-3.5-turbo-0301",
                    messages: [{ role: "user", "content": question }],
                })
        }
        1.upto(1200) do |i|
            say "\r[#{LOADING_CHAR[i % 4]}]", nil, false
            sleep 0.2
            break unless thread.alive?
        end
        if response&.has_key? "error"
            say("\r[ERROR] Invalid Secret API Key.\n" \
            "Please set the correct secret API key again from the following command.\n" \
            "> $sudo chat_cli init", :red); return if response&.dig("error", "code") == "invalid_api_key"

            say "\r[ERROR] Unknown Error", :red
            return
        end
        say "\rYou: #{question}"
        say "GPT: #{response&.dig("choices", 0, "message", "content")}"
    end

    desc "init", "Set the Secret API Key."
    def init()
        token = ask "Please enter your Secret API Key.\n" \
        "If it has not been issued yet, please go to the following site to issue a new API key.\n" \
        "  https://platform.openai.com/account/api-keys\n" \
        "API Key:"
        File.open(File.expand_path("../.env", __dir__), "w") do |file|
            file.write("OPENAI_ACCESS_TOKEN = #{token}")
        end
    end

    desc "usage", "Check API usage"
    def usage()
        say "Please check bellow Web Site.\n" \
        "  https://platform.openai.com/account/usage"
    end

    def self.exit_on_failure?
        true
    end
  end
end
