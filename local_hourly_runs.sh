#!/bin/bash

# 1. SOME JAIL SCRAPING MODULES ARE RUN EVERY HOUR
# for some effed up reason, only 7 jails are working via PyAn tasks...
# and the six 6 dockets in this script only work on my local network
# bc rural MS internet is fucking trash, I scrape 2 largest dockets every odd hour
# and the four smaller dockets every even hour
cd ~/code/jail_scrapers
the_hour="$(date +"%H")"
if (( $(( ${the_hour#0} % 2 )) == 1 )); then
    pipenv run python scrapers.py kcdc,jcdc 7
else
    pipenv run python scrapers.py tcdc,jcj,ccdc,ccj 7
fi
# clean the data and upload any new pdfs
pipenv run python polish_data.py
pipenv run python pdf_stuff.py

# 2. RUN THE MSLEG SCRAPERS LOCALLY EVERY HOUR
cd ~/code/msleg_scraper
pipenv run python msleg_scraper.py
pipenv run python senate_cmte_agendas.py

# CHECK MDOC FOR COVID UPDATES EVERY HOUR
cd ~/code/mdoc_scraper && pipenv run python mdoc_covid.py

# TODO: find out how to automate deleting from reading list
cd ~/code/reading_list
if (( $(( ${the_hour#0} % 2 )) == 1 )); then
    pipenv run python muh_news.py
elif [ "$the_hour" = "05" ]; then
    pipenv run python get_reading_list.py
fi
