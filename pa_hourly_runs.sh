#!/bin/bash
# if PythonAnywhere can run any of my scrapers, that's where I run them.
# For now, that's everything other than msleg_scraper.py & pdf_stuff.py.
# This bash script is run as an hourly task at PythonAnywhere.

# 1. THE JAIL SCRAPING MODULES ARE RUN EVERY HOUR
python3 ~/code/jail_scrapers/scrapers.py
python3 ~/code/jail_scrapers/polish_data.py

# 2. A FEW SCRIPTS WILL ONLY RUN EVERY OTHER HOUR
# a. Every odd hour, the SOS scraper runs
# b. Every even hour, the MDOC scraper & a news scraper run
the_hour="$(date +"%H")"
if (( "$[ ${the_hour#0} % 2 ]" == 1 )); then
    python3 ~/code/sos_scraper/sos_scraper.py
else
    python3 ~/code/mdoc_scraper/mdoc_scraper.py
    python3 ~/code/reading_list/muh_news.py
fi

# 3. FINALLY, CERTAIN SCRIPTS ONLY RUN DURING TARGETTED HOURS OF THE DAY
# a. Every hour, 9am - 7pm, if applicable, a scheduled tweet is tweeted.
# b. Only once per day, at 1am, is WaPo's database checked for updates.
if (( ${the_hour#0}>8 && ${the_hour#0}<20 )); then
    python3 ~/code/scheduled_tweets/scheduled_tweets.py
elif [ "$the_hour" = "1" ]; then
    python3 ~/code/police_shootings/police_shootings.py
fi
