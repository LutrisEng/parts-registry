import { Controller } from "@hotwired/stimulus"
import Client from "shopify-buy";

const client = Client.buildClient({
    domain: 'shop.parts.lutris.engineering',
    storefrontAccessToken: '9722de359226bc518f0e6ea1b40cba4f'
});

export default class AddToCartController extends Controller {
    static values = {
        variantId: String
    }

    async add() {
        const variantId = this.variantIdValue
        console.log('Adding to cart!', { variantId })
        let checkout = await client.checkout.create()
        console.log('Created checkout', { checkout })
        checkout = await client.checkout.addLineItems(checkout.id, [{ variantId, quantity: 1 }])
        console.log('Added line item', { checkout })
        location.href = checkout.webUrl
    }
}