module Images
  class VersionGetter
    include Interactor

    SELECT_COLUMNS = %i[id created_at end_date].freeze

    def call
      init
      return unless any_versions?

      find_versions
    end

    private

    def init
      @image = context.image
      context.versions = []
    end

    def any_versions?
      @image.prev_image_id || @image.latest_image_id || @image.end_date
    end

    def find_versions
      context.versions = query
    end

    def query
      Image.select(SELECT_COLUMNS)
           .where(prev_image_id: @image.id)
           .or(Image.select(SELECT_COLUMNS)
                     .where(latest_image_id: @image.id))
           .order(:created_at).to_sql
    end
  end
end