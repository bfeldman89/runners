#!/bin/bash
source ~/.bashrc

# RUN EVERY HOUR ON THE HOUR
cd ~/code/jail_scrapers && python3 scrapers.py && python3 polish_data.py
cd ~/code/mdoc_scraper && python3 mdoc_scraper.py
cd ~/code/sos_scraper && python3 sos_scraper.py
cd ~/code/reading_list && python3 muh_news.py

# RUN EVERY HOUR DEPENDING ON THE HOUR
the_hour="$(date +"%H")"
echo "Current hour : $the_hour"

if ((9 <= $the_hour) && ($the_hour<= 19 )); then
    echo "it's between 9am & 9pm"
    cd ~/code/scheduled_tweets && python3 scheduled_tweets.py
else
    echo "it's way too late/early for tweets"
fi

if [ $the_hour = "1" ]; then
    echo "bc it's 1am, umma check WaPo for fatal force updates"
    cd ~/code/police_shootings && python3 police_shootings.py
else
    echo "nah. I only check WaPo for fatal force updates at 1am"
fi
