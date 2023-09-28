#!/bin/bash

# 1. A FEW SCRIPTS WILL ONLY RUN EVERY OTHER HOUR
# a. Every odd hour, the jail scrapers run
# b. Every even hour, a few other scrapers/scripts run

the_hour="$(date +"%H")"
if (( $(( ${the_hour#0} % 2 )) == 1 )); then
    cd ~/code/jail_scrapers && pipenv run python scrapers.py 
else
    cd ~/code/jail_scrapers && pipenv run python polish_data.py
    cd ~/code/reading_list && pipenv run python muh_news.py
    # cd ~/code/mdoc_scraper && pipenv run python mdoc_scraper.py
    # cd ~/code/sos_scraper && pipenv run python sos_scraper.py
fi

# 2. CERTAIN SCRIPTS ONLY RUN DURING TARGETTED HOURS OF THE DAY
# a. Every hour, 9am - 7pm, if applicable, a scheduled tweet is tweeted.
# b. Only once per day, at 1am, is WaPo's database checked for updates.

if (( ${the_hour#0}>9 && ${the_hour#0}<19 )); then
    cd ~/code/scheduled_tweets && pipenv run python scheduled_tweets.py
fi
