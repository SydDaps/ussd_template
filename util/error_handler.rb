# frozen_string_literal: true

class ProcessingError < StandardError
  attr_reader :page

  def initialize(msg: 'default error message', page: {})
    super(msg)
    @page = page
  end
end

error do
  env['sinatra.error'].page
end
