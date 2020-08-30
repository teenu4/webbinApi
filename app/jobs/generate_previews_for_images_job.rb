class GeneratePreviewsForImagesJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default
  sidekiq_options retry: false

  def perform(*args)
    Scripts::MassPreviewGenerator.call(image_ids: args[0][:image_ids])
  end
end