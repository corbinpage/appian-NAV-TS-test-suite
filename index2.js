
var webdriverio = require('webdriverio');
var options = { desiredCapabilities: { browserName: 'firefox' } };
var client = webdriverio.remote(options);

// Test Suite variables
var waitTime = 10000; 
var environment = 'https://navlabsdev.appiancloud.com/suite';
var tempo = environment + '/tempo';
var design = environment + '/design';
var designer = environment + '/designer';

function sign_in(username, password) {
  client
    .init()
    .url(design)
    .setValue('[name="un"]', username)
    .setValue('[name="pw"]', password)
    .getText('.someElem=WebdriverIO is the best')
    .click('input=Sign In')
    .getTitle().then(function(title) {
      console.log('Title is: ' + title);
          // outputs: "Title is: WebdriverIO (Software) at DuckDuckGo"
        })
    .end();


  // driver.get(environment);
  // driver.findElement(By.name('un')).sendKeys(username);
  // driver.findElement(By.name('pw')).sendKeys(password);
  // driver.findElement(By.name('pw')).submit();
}

sign_in('cpage', '');

