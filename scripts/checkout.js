import { test, expect } from '@playwright/test';

test('checkout', async ({ page }) => {
	const navigationPromise = page.waitForNavigation();

	// navigate to our target web page
	await page.goto('https://danube-web.shop');

	// add the first item to the cart
	await page.locator(`.preview:nth-child(1) > .preview-author`).click();
	await page.locator('.detail-wrapper > .call-to-action').click();
	await page.locator('#logo').click();

	// wait until navigation is complete
	await navigationPromise;

	// navigate to cart and proceed
	await page.locator('#cart').click();
	await page.locator('.cart > .call-to-action').click();
	await page.locator('#s-name').click();

	// fill out checkout info
	await page.locator('#s-name').type('Max');
	await page.locator('#s-surname').type('Mustermann');
	await page.locator('#s-address').type('Charlottenstr. 57');
	await page.locator('#s-zipcode').type('10117');
	await page.locator('#s-city').type('Berlin');
	await page.locator('#s-company').type('Firma GmbH');
	await page.locator('.checkout > form').click();
	await page.locator('#asap').click();

	// confirm checkout
	await page.locator('.checkout > .call-to-action').click();

	// wait until the order confirmation message is shown
	await page.waitForSelector('#order-confirmation', { visible: true });
});
