require_relative '../lib/file_watcher'
require 'pry'

describe FileWatcher do
  it 'should process any files in the incoming' do
    5.times do
      File.open("incoming/#{(rand * 1000).to_i}.log", 'w') do |file|
        file.write ['Name', 'Age', 'Gender', (rand * 100).to_i].join(',')
      end
    end
    file_processor = spy('File Processor')
    file_watcher = FileWatcher.new(file_processor)

    file_watcher.call

    expect(file_processor).to have_received(:call).exactly(5).times
  end
end
