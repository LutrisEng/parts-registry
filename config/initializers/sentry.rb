# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  print "Not using Sentry since we're in #{Rails.env}\n"
else
  Sentry.init do |config|
    config.dsn = 'https://45dba99091084fb8b2a6859bd36e7981@o1155807.ingest.sentry.io/6377927'
    config.breadcrumbs_logger = %i[active_support_logger http_logger]
    config.traces_sample_rate = 1.0
    config.environment = Rails.env
  end
end
