require 'twilio-ruby'

class Sms
  MAX_DELIVERY_MINS = 60
  TIME_FORMAT = "%H:%M"

  def initialize(config:, client: Twilio::REST::Client.new(config[:account_sid], config[:auth_token]))
    @config = config
    @client = client
  end

  def send_text
    messages.create(message_args)
  end

  private

  attr_reader :config, :client

  def messages
    client.messages
  end

  def message_args
    { from: config[:from],
      to: config[:to],
      body: config[:body] % delivery_time }
  end

  def delivery_time
    (Time.now + 60 * MAX_DELIVERY_MINS).strftime(TIME_FORMAT)
  end
end
