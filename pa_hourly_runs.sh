#!/bin/bash

# to run this script, the following cron job is set up:
# 05 * * * * source ~/.bashrc && cd ~/code/runners && ./pa_hourly_runs.sh

# RUN EVERY HOUR ON THE HOUR
python3 ~/code/jail_scrapers/scrapers.py
python3 ~/code/jail_scrapers/polish_data.py
python3 ~/code/mdoc_scraper/mdoc_scraper.py
python3 ~/code/sos_scraper/sos_scraper.py
python3 ~/code/reading_list/muh_news.py

# RUN EVERY HOUR DEPENDING ON THE HOUR
the_hour="$(date +"%H")"
echo "Current hour : $the_hour"

if (( the_hour>8 && the_hour<20 )); then
    python3 ~/code/scheduled_tweets/scheduled_tweets.py
else
    echo "it's way too late/early for tweets"
fi

if [ $the_hour = "1" ]; then
    echo "bc it's 1am, umma check WaPo for fatal force updates"
    python3 ~/code/police_shootings/police_shootings.py
else
    echo "nah. I only check WaPo for fatal force updates at 1am"
fi
