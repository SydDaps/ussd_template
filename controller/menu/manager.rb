# frozen_string_literal: true

module Menu
  class Manager < Menu::Base
    def process
      tracker = ActivityTracker.where(mobile_number: @mobile_number, session_id: @session_id).order('created_at DESC').first
      params = @params.merge(tracker: tracker)
      case tracker.menu_function
      when MAIN_MENU
        Menu::Main.process(params)
      when MORE_MENU
        Menu::More.process(params)
      when PAGINATE_MENU
        Menu::Paginate.process(params)
      end
    end
  end
end
