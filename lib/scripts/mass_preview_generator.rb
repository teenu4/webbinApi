module Scripts
  class MassPreviewGenerator
    include Interactor

    def call
      send_notification(:started, context.image_ids.count)
      generate_previews
      send_notification(:finished)
    end

    private

    def generate_previews
      context.generated_count = 0
      context.skipped_count = 0
      Image.where(id: context.image_ids).each do |image|
        if image.desktop_file.attached? && !image.preview_file.attached?
          Images::PreviewCreator.call(image: image)
          context.generated_count += 1
        else
          context.skipped_count += 1
          puts "can't generate preview for image id: #{image.id}"
          puts "image.desktop_file.attached?: #{image.desktop_file.attached?}"
          puts "!image.preview_file.attached?: #{!image.preview_file.attached?}"
        end
      end
    end

    def send_notification(status, count = nil)
      text = if status == :started
               ":soon:#{status.to_s.camelize} generating #{count} image previews.
`Environment: #{Rails.env}`"
             else
               "#{context.skipped_count.zero? ? ':white_check_mark:' : ':fast_forward:'}#{status.to_s.camelize} generating image previews.
`Generated: #{context.generated_count}`
`Skipped: #{context.skipped_count}`"
             end
      Notifiers::Slack.call(text: text)
    end
  end
end