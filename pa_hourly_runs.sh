#!/bin/bash

# 1. THE JAIL SCRAPING MODULES ARE RUN EVERY HOUR
# Only 7 dockets are working via PyAn (mcdc, prcdf, lcdc, jcadc, hcdc, acdc, and jcj).
# The other 5 dockets (kcdc, jcdc, tcdc, ccdc, and ccj) are scraped from the local netweork.
# Because MS internet is trash, I scrape 2 dockets every odd hour and 3 dockets every even hour.

cd ~/code/jail_scrapers
pipenv run python scrapers.py mcdc,lcdc,jcadc,hcdc,acdc,jcj 5
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

if (( ${the_hour#0}>9 && ${the_hour#0}<19 )); then
    cd ~/code/scheduled_tweets && pipenv run python scheduled_tweets.py
fi
