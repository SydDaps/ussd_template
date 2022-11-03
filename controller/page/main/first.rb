# frozen_string_literal: true

module Page
  module Main
    class First < Menu::Base
      def process
        case @activity_type
        when REQUEST
          render_current_page
        when RESPONSE
          process_response
        end
      end

      private

      def process_response
        case @ussd_body
        when '01'
          Menu::More.process(@params.merge(page: '1'))
        when '1'
          Page::Main::Second.process(@params.merge(activity_type: REQUEST))
        when '2'
          Page::Paginate::First.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Option not implemented. \n"
          render_current_page
        end
      end

      def render_current_page
        render_page({
                      page: '1',
                      menu_function: MAIN_MENU,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        message = <<~MSG
          USSD Template
          1.Sample basic functions
          2.Sample Pagination

          01.More
        MSG

        @message_prepend + message
      end
    end
  end
end
