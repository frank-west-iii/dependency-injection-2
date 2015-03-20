require_relative '../lib/file_watcher'
require 'pry'

describe FileWatcher do
  NUMBER_OF_FILES = 5

  before(:each) do
    NUMBER_OF_FILES.times do
      File.open("incoming/#{(rand * 1000).to_i}.log", 'w') do |file|
        file.write ['Name', 'Age', 'Gender', (rand * 100).to_i].join(',')
      end
    end
  end

  after(:each) do
    FileUtils.rm Dir['incoming/*.log', 'errors/*.log', 'completed/*.log']
  end

  it 'should process any files in the incoming folder' do
    file_processor = spy('File Processor')
    file_watcher = FileWatcher.new(file_processor)

    file_watcher.call

    expect(file_processor).to have_received(:call).exactly(NUMBER_OF_FILES).times
  end

  it 'should move the successfully processed files to the completed folder' do
    file_processor = double('File Processor')
    allow(file_processor).to receive(:call).and_return(true)
    file_watcher = FileWatcher.new(file_processor)

    file_watcher.call

    expect(Dir['incoming/*.log'].size).to eq(0)
    expect(Dir['completed/*.log'].size).to eq(5)
  end

  it 'should move the unsuccessfully processed files to the errors folder' do
    file_processor = double('File Processor')
    allow(file_processor).to receive(:call).and_return(false)
    file_watcher = FileWatcher.new(file_processor)

    file_watcher.call

    expect(Dir['incoming/*.log'].size).to eq(0)
    expect(Dir['errors/*.log'].size).to eq(5)
  end
end
