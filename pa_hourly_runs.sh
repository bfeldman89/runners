#!/bin/bash

# 1. THE JAIL SCRAPING MODULES ARE RUN EVERY HOUR
cd ~/code/jail_scrapers
pipenv run python scrapers.py mcdc,prcdf,lcdc,jcadc,hcdc,acdc,jcj 5
# for some effed up reason, only these 7 jails are working via PyAn tasks...
# the other 6 jails only work on my local network and run via cron
pipenv run python polish_data.py

# 2. A FEW SCRIPTS WILL ONLY RUN EVERY OTHER HOUR
# a. Every odd hour, the SOS scraper runs
# b. Every even hour, the MDOC scraper & a news scraper run
the_hour="$(date +"%H")"
if (( $(( ${the_hour#0} % 2 )) == 1 )); then
    cd ~/code/sos_scraper && pipenv run python sos_scraper.py
else
    cd ~/code/mdoc_scraper && pipenv run python mdoc_scraper.py
    cd ~/code/reading_list && pipenv run python muh_news.py
fi

# 3. FINALLY, CERTAIN SCRIPTS ONLY RUN DURING TARGETTED HOURS OF THE DAY
# a. Every hour, 9am - 7pm, if applicable, a scheduled tweet is tweeted.
# b. Only once per day, at 1am, is WaPo's database checked for updates.
if (( ${the_hour#0}>7 && ${the_hour#0}<21 )); then
    cd ~/code/scheduled_tweets && pipenv run python scheduled_tweets.py
fi
