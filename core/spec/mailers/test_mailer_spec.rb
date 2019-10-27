require 'spec_helper'
require 'email_spec'

describe Viauco::TestMailer, type: :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before { create(:store) }

  let(:user) { create(:user) }

  context ':from not set explicitly' do
    it 'falls back to viauco config' do
      message = Viauco::TestMailer.test_email('test@example.com')
      expect(message.from).to eq([Viauco::Store.current.mail_from_address])
    end
  end

  it 'confirm_email accepts a user id as an alternative to a User object' do
    expect do
      Viauco::TestMailer.test_email('test@example.com')
    end.not_to raise_error
  end

  context 'action mailer host' do
    it 'falls back to viauco store url' do
      ActionMailer::Base.default_url_options = {}
      Viauco::TestMailer.test_email('test@example.com').deliver_now
      expect(ActionMailer::Base.default_url_options[:host]).to eq(Viauco::Store.current.url)
    end

    it 'uses developer set host' do
      ActionMailer::Base.default_url_options[:host] = 'test.test'
      Viauco::TestMailer.test_email('test@example.com').deliver_now
      expect(ActionMailer::Base.default_url_options[:host]).to eq('test.test')
    end
  end
end
