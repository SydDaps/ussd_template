# frozen_string_literal: true

module Page
  module Paginate
    class First < Menu::Base
      def process
        case @activity_type
        when REQUEST
          process_request
        when RESPONSE
          process_response
        end
      end

      private

      def process_request
        fetch_data
        structure_data
        render_current_page
      end

      def fetch_data
        @data = [
          {
            'key' => 'option 1',
            'value' => 'value 1'
          },
          {
            'key' => 'option 2',
            'value' => 'value 2'
          },
          {
            'key' => 'option 3',
            'value' => 'value 3'
          },
          {
            'key' => 'option 4',
            'value' => 'value 4'
          },
          {
            'key' => 'option 5',
            'value' => 'value 5'
          },
          {
            'key' => 'option 6',
            'value' => 'value 6'
          }
        ]
      end

      def structure_data
        @structured_data = paginate_data(@data, 2, 'key')

        @current_data = @structured_data[@pagination_page]

        return if @current_data

        @pagination_page = 0
        @current_data = @structured_data[@pagination_page]
        @message_prepend = "Invalid input. \n"
        error_page = render_current_page
        raise ProcessingError.new(page: error_page)
      end

      def process_response
        case @ussd_body
        when '01'
          @pagination_page += 1
          process_request
        when '02'
          @pagination_page -= 1
          process_request
        else
          fetch_data
          structure_data
          process_option_selected
        end
      end

      def process_option_selected
        data = @current_data.find { |data_options| data_options['option'] == @ussd_body }

        unless data
          @message_prepend = "Invalid input. \n"
          error_page = render_current_page
          raise ProcessingError.new(page: error_page)
        end

        Cache.store(
          @params.merge(
            cache: { data: data }.to_json
          )
        )

        Page::Paginate::Second.process(@params.merge(activity_type: REQUEST))
      end

      def render_current_page
        render_page({
                      page: '1',
                      menu_function: PAGINATE_MENU,
                      activity_type: RESPONSE,
                      pagination_page: @pagination_page
                    })
      end

      def display_message
        message = <<~MSG
          Sample data

          #{@current_data.pluck('option_string').join}
        MSG

        message += "01.More\n" if @structured_data[@pagination_page + 1]
        message += "02.Back\n" if (@pagination_page - 1).positive?

        @message_prepend + message
      end
    end
  end
end
