// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import $ from "cash-dom"
import Client from "shopify-buy";

Sentry.init({
    dsn: "https://45dba99091084fb8b2a6859bd36e7981@o1155807.ingest.sentry.io/6377927",
    integrations: [new Sentry.BrowserTracing({})],

    // Set tracesSampleRate to 1.0 to capture 100%
    // of transactions for performance monitoring.
    // We recommend adjusting this value in production
    tracesSampleRate: 1.0,
});

const client = Client.buildClient({
    domain: 'shop.parts.lutris.engineering',
    storefrontAccessToken: '9722de359226bc518f0e6ea1b40cba4f'
});

$(() => {
    $('[data-add-to-cart]').each((element) => {
        const cel = $(element)
        const variantId = cel.data('add-to-cart')
        cel.on('click', async function() {
            console.log('Adding to cart!', { variantId })
            let checkout = await client.checkout.create()
            console.log('Created checkout', { checkout })
            checkout = await client.checkout.addLineItems(checkout.id, [{ variantId, quantity: 1 }])
            console.log('Added line item', { checkout })
            location.href = checkout.webUrl
        })
    })
})
