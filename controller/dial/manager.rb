# frozen_string_literal: true

module Dial
  class Manager
    def initialize(json)
      params = JSON.parse(json)&.with_indifferent_access
      @message_type = params[:msg_type]
      @params = params
    end

    def process
      case @message_type
      when '0'
        first_dial
      when '1'
        continuous_dial
      end
    end

    private

    def first_dial
      Menu::Main.process(@params.merge(page: '1', activity_type: REQUEST))
    end

    def continuous_dial
      Menu::Manager.process(@params)
    end
  end
end
