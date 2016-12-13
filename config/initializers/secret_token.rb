RaspberryCook::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test? 
  ('a'*30)
else
  ENV['SECRET_TOKEN']
end