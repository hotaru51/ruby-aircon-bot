require'slack-ruby-bot'
require 'logger'

PID_FILE = "#{__dir__}/tmp/pid".freeze
LOG_FILE = "/var/log/ruby-aircon-bot/ruby-aircon-bot.log".freeze

SlackRubyBot::Client.logger.level = Logger::WARN
SlackRubyBot.configure do |config|
  config.aliases = ['ルビィ']
  config.logger = Logger.new(LOG_FILE)
end

class RubyAirconBot < SlackRubyBot::Bot
  @@error_message = 'ぅゅ…　失敗しちゃったよぉ…'
  @@irsend_command = 'irsend SEND_ONCE aircon'
  
  command '冷房つけて' do |client, data, match|
    if system("#{@@irsend_command} cool_28")
      client.say({channel: data.channel, text: '冷房つけルビィ！'})
    else
      client.say({channel: data.channel, text: @@error_message})
    end
  end

  command 'ドライつけて' do |client, data, match|
    if system("#{@@irsend_command} dry_28")
      client.say({channel: data.channel, text: '除湿すルビィ！'})
    else
      client.say({channel: data.channel, text: @@error_message})
    end
  end

  command '暖房つけて' do |client, data, match|
    if system("#{@@irsend_command} heat_22")
      client.say({channel: data.channel, text: '暖房つけルビィ！'})
    else
      client.say({channel: data.channel, text: @@error_message})
    end
  end

  command 'エアコンけして' do |client, data, match|
    if system("#{@@irsend_command} off")
      client.say({channel: data.channel, text: 'エアコン止めルビィ！'})
    else
      client.say({channel: data.channel, text: @@error_message})
    end
  end
end

File.open(PID_FILE, 'w') do |f|
  f.write($$)
end

at_exit do
  File.delete(PID_FILE) if File.exist?(PID_FILE)
end

RubyAirconBot.run
