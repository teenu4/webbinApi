module Images
  class PreviewCreator
    include Interactor

    PREVIEW_SIZE = [944, 590].freeze

    def call
      init
      edit_image
      attach_image
    ensure
      close_file
    end

    private

    def init
      # why minimagick creates this copy?!
      @file_names = [preview_file_name, "#{preview_file_name}-0"]
      @file = File.open(@file_names[0], 'wb')
      File.open(@file.path, 'wb') { |f| f.puts context.image.desktop_file.blob.download }
    end

    def edit_image
      @image = MiniMagick::Image.new(@file.path)
      @image.resize(PREVIEW_SIZE[0])
      @image.crop("#{PREVIEW_SIZE[0]}x#{PREVIEW_SIZE[1]}")
    end

    def attach_image
      attached = false
      @file_names.each do |name|
        next unless File.exists? name

        context.image.preview_file.attach(io: File.open(name),
                                          filename: name)
        attached = true
      end
      raise "Can't find file!" unless attached
    end

    def close_file
      return unless @image

      @image.destroy!
      @file_names.each do |name|
        File.delete(name) if File.exist?(name)
      end
    end

    def preview_file_name
      "#{context.image.id}_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}"
    end

  end
end
