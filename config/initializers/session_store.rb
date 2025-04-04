# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: '_jungle_session', same_site: :lax
