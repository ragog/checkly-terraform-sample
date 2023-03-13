import { test, expect } from '@playwright/test';

test('test', async () => {
	test.setTimeout(100000);

	await page.goto('https://demo.vercel.store/');

	await page.screenshot({ path: 'scr1.png' });

	await page.locator('text=AllApparelShop AllSearch >> [placeholder="Search for products\\.\\.\\."]').click();
	await page.locator('text=AllApparelShop AllSearch >> [placeholder="Search for products\\.\\.\\."]').fill('pants');
	await page.locator('text=AllApparelShop AllSearch >> [placeholder="Search for products\\.\\.\\."]').press('Enter');

	await page.screenshot({ path: 'scr2.png' });

	await page.locator('img[alt="Unisex Joggers"]').click();
	await page.locator('[aria-label="size l"]').click();

	await page.screenshot({ path: 'scr3.png' });

	await page.locator('text=Add To Cart').click();
	await page.locator('text=Proceed to Checkout').click();

	await page.screenshot({ path: 'scr4.png' });
});
