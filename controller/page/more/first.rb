# frozen_string_literal: true

module Page
  module More
    class First < Menu::Base
      def process
        render_page({
                      page: '1',
                      menu_function: MORE_MENU
                    })
      end

      private

      def display_message
        message = <<~MSG
          USSD TEMPLATE

          4.Option 5
          5.Option 6

          02.Back
        MSG

        @message_prepend + message
      end
    end
  end
end
