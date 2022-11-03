# frozen_string_literal: true

module Menu
  class Base
    include ::Paginator

    def initialize(params)
      @params = params
      @tracker = params[:tracker]

      @activity_type = params[:activity_type] || @tracker&.activity_type
      @ussd_body = params[:ussd_body]
      @mobile_number = params[:msisdn]
      @session_id = params[:session_id]
      @message_append = params[:message_append]
      @message_prepend = params[:message_prepend].to_s
      initialize_pages
    end

    def fetch_data
      @cache = Cache.fetch(@params).cache
      @data = JSON.parse(@cache).with_indifferent_access
    end

    def self.process(params)
      new(params).process
    end

    def end_session(message = 'Service Unavailable. Please try again later')
      Session::Manager.end(
        @params.merge(display_message: message)
      )
    end

    def render_main_menu(options = {})
      @params[:page] = '1'
      Page::Main::First.process(@params.merge(options))
    end

    def render_page(options)
      params = @params.merge(options)

      tracker_data = {
        message_type: params[:msg_type],
        page: params[:page],
        ussd_body: params[:ussd_body],
        menu_function: params[:menu_function],
        mobile_number: @mobile_number,
        session_id: params[:session_id],
        activity_type: params[:activity_type],
        pagination_page: params[:pagination_page]
      }

      ActivityTracker.create(tracker_data)

      Session::Manager.continue(
        @params.merge(display_message: display_message)
      )
    end

    private

    def initialize_pages
      @page = @params[:page] || @tracker&.page
      @pagination_page = @tracker&.pagination_page.to_i
    end
  end
end
