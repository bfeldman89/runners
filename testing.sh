#!/bin/bash

# create the local variable of current hour
the_hour="$(date +"%H")"
echo "Current hour : $the_hour"

# an if/then relying on local variable
if [ $the_hour = "21" ]; then
    echo "bc it's 9-something-pm, umma check WaPo for fatal force updates"
    cd ~/code/police_shootings && python3 police_shootings.py
fi

# run the other scrapers
cd ~/code/msleg_scraper && python3 msleg_scraper.py
cd ~/code/mdoc_scraper && python3 mdoc_scraper.py
cd ~/code/sos_scraper && python3 sos_scraper.py
cd ~/code/reading_list && python3 muh_news.py
