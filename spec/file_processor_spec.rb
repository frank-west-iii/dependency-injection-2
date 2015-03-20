require_relative '../lib/file_processor'

describe FileProcessor do
  it 'should process files' do
    notifier = double("Notifier")
    allow(notifier).to receive(:call).and_return(true)
    file_processor = FileProcessor.new(notifier)

    result = file_processor.call("file")

    expect(result).to eq(true)
  end

  it 'should notify the admin' do
    notifier = spy("Notifier")
    file_processor = FileProcessor.new(notifier)

    file_processor.call("File")

    expect(notifier).to have_received(:call)
  end
end
