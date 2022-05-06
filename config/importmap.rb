# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'admin'
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'shopify-buy' # @2.15.1
pin "@rails/ujs", to: "@rails--ujs.js" # @7.0.2
