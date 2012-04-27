PagePerformance
===============

Test the page performance of a single or more websites to compare them. You receive
the average load time of each website. You can also get a summary about the used script 
and / or iframe tags used in each page. 

This library uses [Phantomjs](http://code.google.com/p/phantomjs/ "Phantomjs"), which is a 
headless, webkit based browser.

Usage
-----

    Pageperformance v. 0.1.5

      This program is intended to test the performance of a website. It uses phantomjs which is a headless,
      webkit based cli browser. 

    usage: run_tests [options]

      -u, --urls 'URLS'                the URLS to test
      -f, --file FILE                  the URLS to test from a file
      -w, --wait TIME                  the time to wait between the requests after the block of URLs
      -r, --repeate INTEGER            amount of repetition
      -o, --output STRING              write results to this output file
      -s, --script                     count the <script> tags
      -i, --iframe                     count the <iframe> tags
      -I, --ignore-ssl-errors          advice Phantomjs to ignore SSL errors
      -q, --quiet                      no output durng program execution
      -h, --help                       show this message
      -v, --version                    show version

Example for running the tests:
------------------------------

    $ ./run_tests -o out -u 'www.nms.de,www.beangie.de' -s -i -r 3
    round 1:
     http://www.nms.de: 522 ms
     http://www.beangie.de: 3487 ms
    round 2:
     http://www.nms.de: 3244 ms
     http://www.beangie.de: 2830 ms
    round 3:
     http://www.nms.de: 475 ms
     http://www.beangie.de: 3857 ms

It's also possible (and mostly more convenient) to put the URLs in a file. One URL per line. Then call
the script like this:

    $ ./run_tests -o out -f file_with_urls -s -i -r 3    

Example output (file)
---------------------

    PagePerformance test results
    ============================

    Test started at: 2012-03-04 23:54:39 +0100

    Results for performance tests for the following URLs:

     + www.nms.de
     + www.beangie.de


    Results:
    --------
     http://www.nms.de: 522 ms
     http://www.beangie.de: 3487 ms
     http://www.nms.de: 3244 ms
     http://www.beangie.de: 2830 ms
     http://www.nms.de: 475 ms
     http://www.beangie.de: 3857 ms

    Average load time time:
    ---------------------
     http://www.nms.de: 1413 ms
     http://www.beangie.de: 3391 ms

    Amount of Tags found per URL:
    -----------------------------
     www.nms.de:
       script: 9
       iframe: 0
     www.beangie.de:
       script: 9
       iframe: 0

    Test ended at: 2012-03-04 23:54:59 +0100

Known Bugs
----------

see https://github.com/andywenk/page_performance/issues?state=open

Next Steps
----------

_ fix bugs
_ enhance
_ write tests !!!



 