PagePerformance
===============

Test the page performance of a single or more websites to compare them. You receive
the average load time of each website. This library uses [Phantomjs](http://code.google.com/p/phantomjs/ "Phantomjs"), which is a 
headless, webkit based browser.

Usage
-----

    Pageperformance v. 0.0.2

    This program is intended to test the performance of a website. It uses phantomjs which is a headless,
    webkit based cli browser. 

    usage: page_performance_test.rb [options]

      -u, --urls 'URLS'                the URLS to test
      -w, --wait TIME                  the time to wait between the requests after the block of URLs
      -r, --repeate INTEGER            amount of repetition
      -o, --output STRING              write results to this output file
      -j, --javascript                 count the <script></script> tags
      -i, --iframe                     count the iframe tags
      -q, --quiet                      no output during program execution
      -h, --help                       show this message
      -v, --version                    show version

Example output (file)
---------------------

    PagePerformance results
    =======================

    Results for performance tests for the following URLs:

    ["nms.de", "beangie.de", "https://www.qraex.de"]

    Results:
    --------
    http://nms.de: 201 ms
    http://beangie.de: 2891 ms
    https://www.qraex.de: 753 ms
    http://nms.de: 193 ms
    http://beangie.de: 3023 ms
    https://www.qraex.de: 727 ms
    http://nms.de: 187 ms
    http://beangie.de: 2824 ms
    https://www.qraex.de: 727 ms
    http://nms.de: 183 ms
    http://beangie.de: 2772 ms
    https://www.qraex.de: 829 ms
    http://nms.de: 187 ms
    http://beangie.de: 2830 ms
    https://www.qraex.de: 769 ms

    Average request time:
    ---------------------
    http://nms.de: 190 ms
    http://beangie.de: 2868 ms
    https://www.qraex.de: 761 ms

Hint
----

This is a first shoot. It's still in early development progress and not feature complete. 