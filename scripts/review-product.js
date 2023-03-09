import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {

 const bookList = [
   "The Foreigner",
   "The Transformation",
   "For Whom the Ball Tells",
   "Baiting for Robot",
 ];

 // navigate to our target web page
 await page.goto("https://danube-webshop.herokuapp.com/");

 // search for keyword
 await page.click(".topbar > input");
 await page.type(".topbar > input", "for");
 await page.click("#button-search");
 await page.waitForSelector(
   ".shop-content > ul > .preview:nth-child(1) > .preview-title"
 );

 // halt immediately if results do not equal expected number
 let resultsNumber = (await page.$$(".preview-title")).length;
 assert.equal(resultsNumber, bookList.length);

 // remove every element found from the original array...
 for (i = 0; i < resultsNumber; i++) {
   const resultTitle = await page.$eval(
     `.preview:nth-child(${i + 1}) > .preview-title`,
     (e) => e.innerText
   );

   const index = bookList.indexOf(resultTitle);
   bookList.splice(index, 1);
 }

 // ...then assert that the original array is now empty
 assert.equal(bookList.length, 0);
});