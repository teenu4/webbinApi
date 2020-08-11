ActiveStorage::Current.host = ENV['API_ROOT'] if Rails.application.config.active_storage.service == :local
