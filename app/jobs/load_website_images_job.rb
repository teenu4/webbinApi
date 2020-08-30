class LoadWebsiteImagesJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default
  sidekiq_options retry: false

  def perform(*args)
    Scripts::MassImageCreator.call(path: args[0][:path], website_id: args[0][:website_id])
  end
end