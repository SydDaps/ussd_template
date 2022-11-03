# frozen_string_literal: true

module Menu
  class Main < Menu::Base
    def process
      case @page
      when '1'
        Page::Main::First.process(@params)
      when '2'
        Page::Main::Second.process(@params)
      end
    end
  end
end
