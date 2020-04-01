#!/bin/bash

# 1. THE JAIL SCRAPING MODULES ARE RUN EVERY HOUR
pipenv run python ~/code/jail_scrapers/scrapers.py
pipenv run python ~/code/jail_scrapers/polish_data.py

# 2. A FEW SCRIPTS WILL ONLY RUN EVERY OTHER HOUR
# a. Every odd hour, the SOS scraper runs
# b. Every even hour, the MDOC scraper & a news scraper run
the_hour="$(date +"%H")"
if (( "$[ ${the_hour#0} % 2 ]" == 1 )); then
    pipenv run python ~/code/sos_scraper/sos_scraper.py
else
    pipenv run python ~/code/mdoc_scraper/mdoc_scraper_v2.py
    pipenv run python ~/code/reading_list/muh_news.py
fi

# 3. FINALLY, CERTAIN SCRIPTS ONLY RUN DURING TARGETTED HOURS OF THE DAY
# a. Every hour, 9am - 7pm, if applicable, a scheduled tweet is tweeted.
# b. Only once per day, at 1am, is WaPo's database checked for updates.
if (( ${the_hour#0}>7 && ${the_hour#0}<21 )); then
    pipenv run python ~/code/scheduled_tweets/scheduled_tweets.py
elif [ "$the_hour" = "07" ]; then
    pipenv run python ~/code/police_shootings/police_shootings.py
fi
