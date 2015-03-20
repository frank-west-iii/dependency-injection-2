require 'fileutils'

class FileWatcher
  def initialize(file_processor)
    @file_processor = file_processor
  end

  def call
    Dir['incoming/*.log'].each do |file|
      if @file_processor.call(File.read(file))
        FileUtils.mv(file, 'completed')
      else
        FileUtils.mv(file, 'errors')
      end
    end
  end
end
