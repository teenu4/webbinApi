require 'slack-notifier'
module Notifiers
  class Slack
    include Interactor

    def call
      send_notification
    end

    private

    def notifier
      ::Slack::Notifier.new(Rails.application.credentials.dig(:slack, :webhook_url))
    end

    def send_notification
      notifier.ping(context.text)
    end
  end
end