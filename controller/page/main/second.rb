# frozen_string_literal: true

module Page
  module Main
    class Second < Menu::Base
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
        when '1'
          end_session('This is a processed response')
        when '02'
          Page::Main::First.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Option not implemented. \n"
          render_current_page
        end
      end

      def render_current_page
        render_page({
                      page: '2',
                      menu_function: MAIN_MENU,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        message = <<~MSG
          Lets test some functions
          1.End session
          3.Test Invalid input
          02.Back
        MSG

        @message_prepend + message
      end

      def render_next_menu
        case @ussd_body
        when '01'
          Menu::More.process(@params.merge(page: '1'))
        else
          render_main_menu({ message_prepend: "option not implemented yet!!!!\n" })
        end
      end
    end
  end
end
