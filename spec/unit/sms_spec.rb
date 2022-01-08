require 'sms'

describe Sms do
  subject(:sms)           { described_class.new(config: config, client: client) }
  let(:config)            { { account_sid: "123",
                             auth_token: "123",
                             from: '+123456789',
                             to: '+987654321',
                             body: "Thank you! Your order was placed and will be delivered before %s" } }
  let(:client)            { double :client, messages: messages }
  let(:messages)          { double :messages }


  describe '#send_text' do
    it 'calls the create method on messages' do
      message_args = { from: config[:from],
                       to: config[:to],
                       body: config[:body] % '18:52' }
      allow(Time).to receive(:now).and_return(Time.parse("17:52"))
      expect(messages).to receive(:create).with(message_args)
      sms.send_text
    end
  end
end
