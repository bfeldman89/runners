#!/bin/bash
source ~/.bashrc

the_hour="$(date +"%H")"
echo "Current hour : $the_hour"

# scrape the jails & run the cleanup script
cd ~/code/jail_scrapers
python3 scrapers.py && python3 polish_data.py

# if/then commands relying on the hour of day
if [ $the_hour = "21" ]; then
    echo "bc it's 9-something-pm, umma check WaPo for fatal force updates"
    cd ~/code/police_shootings && python3 police_shootings.py
fi

# TODO tweet if time w/in range
#

# run the other scrapers
cd ~/code/scheduled_tweets && python3 scheduled_tweets.py
cd ~/code/mdoc_scraper && python3 mdoc_scraper.py
cd ~/code/sos_scraper && python3 sos_scraper.py
cd ~/code/reading_list && python3 muh_news.py
