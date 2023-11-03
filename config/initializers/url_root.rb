Rails.application.configure do
  config.url_root = if Rails.env.production?
                      %Q[https://#{ENV["HOST"]}]
                    else
                      port = ENV.fetch("PORT") { 3000 }
                      %Q[http://#{ENV["HOST"]}:#{port}]
                    end
end