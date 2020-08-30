module Scripts
  class MassImageCreator
    include Interactor

    PLATFORM_MASK = '_%s.'
    PLATFORMS = {
        m: :mobile,
        d: :desktop,
        t: :tablet
    }
    FILE_EXTENSIONS = %w[jpg png]
    IGNORED_FILENAMES = %w[. .. .DS_Store]

    def call
      attach_images
      context.image_ids.uniq!
      GeneratePreviewsForImagesJob.perform_later(image_ids: context.image_ids)
    end

    private

    def attach_images
      context.image_ids = []
      files = Dir.foreach(context.path).to_a.reject { |f| IGNORED_FILENAMES.include?(f) }
      send_notification(:started, files.count)
      files.each { |filename| process_filename(filename) }
      send_notification(:finished)
    end

    def process_filename(filename)
      platform = determine_platform(filename)
      internal_name = get_internal_name(filename, platform)
      display_name = get_display_name(internal_name)
      image = Image.where(internal_name: internal_name, website_id: context.website_id).first_or_initialize
      image.display_name ||= display_name
      unless image.send("#{PLATFORMS[platform]}_attached")
        attach_file(filename, PLATFORMS[platform], image)
      end
      image.save!
      context.image_ids << image.id
      # puts "#{filename} #{internal_name} #{display_name.inspect} #{platform}"
    end

    def attach_file(filename, platform, image)
      image.send("#{platform}_file").attach(io: File.open(context.path + filename),
                                            filename: filename)
    end

    def determine_platform(filename)
      PLATFORMS.each do |p, _|
        return p if filename.include?(PLATFORM_MASK % p.to_s)
      end
      raise "Unknown platform for filename #{filename}!"
    end

    def get_internal_name(filename, platform)
      FILE_EXTENSIONS.each do |ext|
        return filename.gsub("#{PLATFORM_MASK % platform.to_s}#{ext}", '') if filename.end_with?(ext)
      end
      raise "Extension is not supported for filename #{filename}!"
    end

    def get_display_name(internal_name)
      internal_name.split(/[^a-z]/)
          .reject { |w| w.empty? }
          .map { |w| w.camelize }
          .join(' ')
    end

    def send_notification(status, count = nil)
      text = if status == :started
               ":soon:#{status.to_s.camelize} loading *#{count}* image files for *#{Website.find(context.website_id).name}*
`Environment: #{Rails.env}`"
             else
               ":white_check_mark:#{status.to_s.camelize} loading image files for *#{Website.find(context.website_id).name}*"
             end

      Notifiers::Slack.call(text: text)
    end
  end
end