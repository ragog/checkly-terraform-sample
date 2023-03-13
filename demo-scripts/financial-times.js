const { chromium } = require('playwright')

async function run () {
  const browser = await chromium.launch()
  const page = await browser.newPage()

  await page.goto('https://www.ft.com/');

  await page.screenshot({ path: 'scr1.png' })

  await page.locator('text=Accept & continue').click();

  await page.locator('text=S&P 500').click();

  await page.locator('text=Data archive').click()

  await page.screenshot({ path: 'scr2.png' })

  const [page1] = await Promise.all([
    page.waitForEvent('popup'),
    page.locator('text=FundsManaged funds service19 hours agoSubscribe to view >> a').click()
  ]);

  await page.screenshot({ path: 'scr3.png' })

  await page.close()
  await browser.close()
}

run()