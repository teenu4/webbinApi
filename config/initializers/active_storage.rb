ActiveStorage::Current.host = Rails.application.credentials[:api_root] if Rails.application.config.active_storage.service == :local
