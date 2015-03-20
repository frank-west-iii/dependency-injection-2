require_relative '../lib/email_notifier'

describe EmailNotifier do
  it 'should email the admin' do
    email_notifier = EmailNotifier.new(['admin@example.com'])

    expect(email_notifier.call).to eq(true)
  end
end
