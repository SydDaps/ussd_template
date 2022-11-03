# frozen_string_literal: true

module Page
  module Paginate
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
        when '02'
          Page::Paginate::First.process(@params.merge(activity_type: REQUEST))
        else
          @message_prepend = "Invalid input. \n"
          render_current_page
        end
      end

      def render_current_page
        fetch_data

        render_page({
                      page: '2',
                      menu_function: PAGINATE_MENU,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        message = <<~MSG
          You selected option #{@data[:data][:option]}

          02.Back
        MSG

        @message_prepend + message
      end
    end
  end
end
