// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"

Sentry.init({
    dsn: "https://45dba99091084fb8b2a6859bd36e7981@o1155807.ingest.sentry.io/6377927",
    integrations: [new Sentry.BrowserTracing({})],

    // Set tracesSampleRate to 1.0 to capture 100%
    // of transactions for performance monitoring.
    // We recommend adjusting this value in production
    tracesSampleRate: 1.0,
})

Rails.start()
