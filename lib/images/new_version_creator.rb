module Images
  class NewVersionCreator
    include Interactor

    def call
      init
      update_flows
      setup_lifespan
      check_for_older_versions
    end

    private

    def init
      @old_image = Image.find(context.image.prev_image_id)
      @new_image = context.image
    end

    # if old image has flows - replace it with new
    # also checking latest_image_id if new version has multiple images
    # to put into flow last image
    def update_flows
      old_id = @old_image.latest_image_id || @old_image.id
      FlowsImage.where(image_id: old_id).update_all(image_id: @new_image.id)
    end

    def setup_lifespan
      @old_image.end_date ||= @new_image.created_at
      @old_image.latest_image_id = @new_image.id
      @old_image.save!
      @new_image.save!
    end

    def check_for_older_versions
      Image.where(latest_image_id: @old_image.id)
           .update_all(latest_image_id: @new_image.id)
    end
  end
end