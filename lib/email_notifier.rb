class EmailNotifier
  def initialize(emails)
    @emails = emails
  end

  def call
    @emails.each do |email|
      # Send email
    end
    true
  end
end
