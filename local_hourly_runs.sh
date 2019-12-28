#!/bin/bash
source ~/.bash_profile
cd ~/code/jail_scrapers && python3 pdf_stuff.py
cd ~/code/msleg_scraper && python3 msleg_scraper.py
cd ~/code/mdoc_scraper && python3 mdoc_scraper.py
cd ~/code/sos_scraper && python3 sos_scraper.py
cd ~/code/scheduled_tweets && python3 scheduled_tweets.py
cd ~/code/reading_list && python3 muh_news.py
