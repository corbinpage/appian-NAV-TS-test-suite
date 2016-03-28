var webdriver = require('webdriverio');
var By = require('selenium-webdriver').By;
var until = require('selenium-webdriver').until;

var driver = new webdriver.Builder()
.forBrowser('firefox')
.build();

var waitTime = 10000; // ms
// driver.get('http://www.google.com/ncr');
// driver.findElement(By.name('q')).sendKeys('webdriver');
// driver.findElement(By.name('btnG')).click();
// driver.wait(until.titleIs('webdriver - Google Search'), 1000);
// driver.findElement("//*[contains(text(), 'My Button')]")
// driver.quit();

var environment = 'https://navlabsdev.appiancloud.com/suite';
var tempo = environment + '/tempo';
var design = environment + '/design';
var designer = environment + '/designer';


function sign_in(username, password) {
  driver.get(environment);
  driver.findElement(By.name('un')).sendKeys(username);
  driver.findElement(By.name('pw')).sendKeys(password);
  driver.findElement(By.name('pw')).submit();
}

function create_new_app(app_name) {
  driver.get(design);
  driver.wait(until.elementLocated(By.xpath("//button[contains(text(), 'New Application')]")), waitTime);
  driver.findElement(By.xpath("//button[contains(text(), 'New Application')]")).click();
  
  driver.wait(until.elementLocated(By.xpath("//button[contains(text(), 'Create')]")), waitTime);
  driver.findElement(By.id('gwt-uid-100')).sendKeys(app_name);
  driver.findElement(By.xpath("//button[contains(text(), 'Create')]")).click();
  driver.wait(until.elementIsEnabled(By.xpath("//button[contains(text(), 'New Application')]")), waitTime);
}
// $x("//*[text()='Name']/ancestor::*[@data-cid][1]//input")

sign_in('cpage', '');
create_new_app("app_name");
// driver.quit();