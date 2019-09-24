require'slack-ruby-bot'

SlackRubyBot.configure do |config|
  config.aliases = ['ルビィ']
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

RubyAirconBot.run
