const { chromium } = require("playwright");

(async () => {

 // launch the browser and open a new page
 const browser = await chromium.launch();
 const page = await browser.newPage();

 const navigationPromise = page.waitForNavigation();

 // navigate to our target web page
 await page.goto("https://danube-webshop.herokuapp.com/");

 // add the first item to the cart
 await page.click(`.preview:nth-child(1) > .preview-author`);
 await page.click(".detail-wrapper > .call-to-action");
 await page.click("#logo");

 // wait until navigation is complete
 await navigationPromise;

 // navigate to cart and proceed
 await page.click("#cart");
 await page.click(".cart > .call-to-action");
 await page.click("#s-name");

 // fill out checkout info
 await page.type("#s-name", "Max");
 await page.type("#s-surname", "Mustermann");
 await page.type("#s-address", "Charlottenstr. 57");
 await page.type("#s-zipcode", "10117");
 await page.type("#s-city", "Berlin");
 await page.type("#s-company", "Firma GmbH");
 await page.click(".checkout > form");
 await page.click("#asap");

 // confirm checkout
 await page.click(".checkout > .call-to-action");

 // wait until the order confirmation message is shown
 await page.waitForSelector("#order-confirmation", { visible: true });

 // close the browser and terminate the session
 await browser.close();
})();