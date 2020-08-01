class ApiController < ActionController::API
  before_action :set_host_for_local_storage

  private

  # is this necessary?
  def set_host_for_local_storage
    return unless Rails.application.config.active_storage.service == :local

    ActiveStorage::Current.host = request.base_url
  end
end
