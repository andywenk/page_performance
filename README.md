PagePerformance
===============

Test the page performance of a single or more websites to compare them. You receive
the average load time of each website. You can also get a summary about the used script 
and / or iframe tags used in each page. 

This library uses [Phantomjs](http://code.google.com/p/phantomjs/ "Phantomjs"), which is a 
headless, webkit based browser.

[![Code Climate](https://codeclimate.com/github/andywenk/page_performance.png)](https://codeclimate.com/github/andywenk/page_performance)

Usage
-----

    PagePerformance v. 0.5.0

    This program is intended to test the performance of a website. It uses phantomjs which is a headless,
    webkit based cli browser.

    usage: run_page_performance [options]

        -u, --urls 'URLS'                the URLS to test
        -f, --file FILE                  the URLS to test from a file
        -a, --bau USER                   Basic-Authentication username
        -p, --bap PASSWORD               Basic-Authentication password
        -B, --base-url                   Use this URL as base
        -w, --wait TIME                  the time to wait between the requests after the block of URLs
        -r, --repeate INTEGER            amount of repetition
        -o, --output STRING              write results to this output file
        -g, --gps-api-key STRING         include Google PageSpeed results with this api key
        -s, --script                     count the <script> tags
        -i, --iframe                     count the <iframe> tags
        -I, --ignore-ssl-errors          advice Phantomjs to ignore SSL errors
        -q, --quiet                      no output durng program execution
        -h, --help                       show this message
        -v, --version                    show version

Example for running the tests:
------------------------------

    $ ./run_page_performance -o out -u 'www.nms.de,www.beangie.de' -s -i -r 3
    round 1:
     http://www.nms.de: 522 ms
     http://www.beangie.de: 3487 ms
    round 2:
     http://www.nms.de: 3244 ms
     http://www.beangie.de: 2830 ms
    round 3:
     http://www.nms.de: 475 ms
     http://www.beangie.de: 3857 ms

It's also possible (and mostly more convenient) to put the URLs in a file. One URL per line. Then call the script like this:

    $ ./run_page_performance -o out -f file_with_urls -s -i -r 3

You can use the <tt>#</tt> character at the beginning of a line for comments.

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

    GoogleSpeedTest per URL:
    -----------------------------
     http://www.beangie.de:
       score: 75
     https://www.nms.de
       score: 99


Google PageSpeed Integration
----------------------------

[Google PageSpeed](https://developers.google.com/speed/pagespeed/service, "Google PageSpeed") service is integrated now.
You can use the option <tt>-g</tt> or <tt>--gps-api-key</tt> and provide your Google API key. This service allows 2500 queries/per day. 
This should be enough for smaller testing purposes. One request for each URL will be fired once at the end of the 
program. Actually it is only available, when you use a result file (<tt>-o</tt>). For now, there is just the score result shown
in the output file (see above). This feature is in early stage and will be enhanced soon.  

Known Bugs
----------

see https://github.com/andywenk/page_performance/issues?state=open

Code Documentation
------------------

http://rdoc.info/github/andywenk/page_performance/master/frames

Debugging
---------

You can debug PagePerformance easily with the awesome [pry gem](http://pry.github.com/). If you start the
program with the environemnt variable <tt>DEBUG=true</tt>, the pry gem is required in <tt>lib/require.rb</tt>. Setting a 
break point inside the code is done by <tt>binding.pry</tt>.

    in lib/page_performance
    def self.parse_cl
      binding.pry
      @argv_parser.parse
    end

    $ DEBUG=true ./run_page_performance -u 'www.google.de'
    From: /Users/andwen/Documents/project/pageperformance/lib/page_performance.rb @ line 28 PagePerformance.parse_cl:

    28:   def self.parse_cl
    => 29:     binding.pry
    30:     @argv_parser.parse
    31:   end

Next Steps
----------

_ fix bugs  
_ enhance  
_ write tests !!!  

License (Apache2)
-----------------

Copyright (c) 2015 Andreas Wenk

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


