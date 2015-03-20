class FileProcessor
  def initialize(notifier)
    @notifier = notifier
  end

  def call(file)
    # Do some processing
    @notifier.call
  end
end
