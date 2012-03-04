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
      -q, --quiet                      count the iframe tags
      -h, --help                       Show this message
      -v, --version                    Show version

Hint
----

This is a first shoot. It's still in early development progress and not feature complete. 