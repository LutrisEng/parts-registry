import { Controller } from "@hotwired/stimulus"
import Client from "shopify-buy";

export default class AddToCartController extends Controller {
    static values = {
        variantId: String,
        domain: String,
        storefrontAccessToken: String
    }

    initialize() {
        this.client = Client.buildClient({
            domain: this.domainValue,
            storefrontAccessToken: this.storefrontAccessTokenValue
        });
    }

    async getCheckout() {
        console.log('Finding checkout...')
        const savedCheckoutId = localStorage.getItem('shopify_checkout_id')
        if (savedCheckoutId) {
            console.log('Found Local Storage item', { savedCheckoutId })
            const checkout = await this.client.checkout.fetch(savedCheckoutId)
            if (!checkout) {
                console.log('Referenced checkout doesn\'t exist.')
                localStorage.removeItem('shopify_checkout_id')
                return await this.getCheckout()
            }
            console.log('Found checkout!')
            return checkout
        } else {
            console.log('No Local Storage item, creating checkout')
            const checkout = await this.client.checkout.create()
            localStorage.setItem('shopify_checkout_id', checkout.id)
            console.log('Created checkout!', { id: checkout.id })
            return checkout
        }
    }

    async add() {
        const variantId = this.variantIdValue
        console.log('Adding to cart!', { variantId })
        let checkout = await this.getCheckout()
        console.log('Got checkout', { checkout })
        checkout = await this.client.checkout.addLineItems(checkout.id, [{ variantId, quantity: 1 }])
        console.log('Added line item', { checkout })
        location.href = checkout.webUrl
    }

    async startCheckout() {
        const checkout = await this.getCheckout()
        console.log('Got checkout', { checkout })
        location.href = checkout.webUrl
    }
}