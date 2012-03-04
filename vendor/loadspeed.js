var page = new WebPage(); 
var t = Date.now();
page.open(phantom.args[0], function (status) {
    if (status !== 'success') {
        console.log('FAIL to load the address ' + address);
    } else {
        t = Date.now() - t;
        console.log(t);
    }
    phantom.exit();
});