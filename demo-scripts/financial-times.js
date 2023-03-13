import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
	test.setTimeout(100000);

	await page.goto('https://www.ft.com/');
	await page.getByRole('link', { name: 'Accept cookies' }).click();
	await page.getByRole('link', { name: 'Visit Markets Data' }).click();
	await page.getByRole('link', { name: 'Asia' }).click();
});
