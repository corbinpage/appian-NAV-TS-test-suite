var webdriver = require('selenium-webdriver');
var By = require('selenium-webdriver').By;
var until = require('selenium-webdriver').until;

var driver = new webdriver.Builder()
  .forBrowser('firefox')
  .build();

// driver.get('http://www.google.com/ncr');
// driver.findElement(By.name('q')).sendKeys('webdriver');
// driver.findElement(By.name('btnG')).click();
// driver.wait(until.titleIs('webdriver - Google Search'), 1000);
// driver.quit();

function sign_in() {
  driver.findElement(By.name('un')).sendKeys('cpage');
  driver.findElement(By.name('pw')).sendKeys('');
  driver.findElement(By.css('input.btn.primary'))
    .then(function(el) {
      el.click();
      // console.log(el.getLocation());
      // console.log(el.getText());
      // console.log(el.isDisplayed());
      // return el.click();
    })
    // page.has_css?("div.aui-DataGrid-Table table")
  driver.wait(until.elementLocated(By.css('div.aui-DataGrid-Table table')), 5000);
}

driver.get('https://navlabsdev.appiancloud.com/suite/design');
sign_in();
// driver.quit();