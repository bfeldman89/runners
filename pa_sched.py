# !/usr/bin/env python3
"""
This module runs all of my scrapers that don't require the pdfkit module bc pythonanywhere doesn't support it.
It is scheduled to run every hour at 20min past the hour. The idea is that my locally run cron job that runs at
5min past the hour shouldn't take more than 15min. The pythonanywhere scheduled task is as follows:

20 * * * * source ~/.bashrc && cd ~/code && python3 pa_sched.py && cd ~/code && python3 jail_scrapers/scrapers.py
"""
import os
import time
import requests
from ..jail_scrapers import polish_data
from ..mdoc_scraper import mdoc_scraper
from ..police_shootings import police_shootings
from ..reading_list import muh_news
from ..scheduled_tweets import scheduled_tweets
from ..sos_scraper import sos_scraper

this_hour = int(time.strftime("%H"))


def main():
    """
    Every even hour, clean the jail data.
    Every odd hour, scrape SOS & MDOC.
    Every hour, 9am - 6pm, send tweet if one's on deck.
    At 7am & 7pm, check WaPo data & wrangle feedly bookmarks
    """

    if (this_hour % 2) == 0:
        os.chdir(f"/{os.getenv('HOME')}/code/jail_scrapers")
        polish_data.main()
        print('polish_data.main() 👌')
    else:
        os.chdir(f"/{os.getenv('HOME')}/code/mdoc_scraper")
        mdoc_scraper.main()
        print('mdoc_scraper.main() 👌')
        sos_scraper.main()
        print('sos_scraper.main() 👌')

    if this_hour in {7, 19}:
        muh_news.main()
        print('muh_news.main() 👌')
        police_shootings.main()
        print('police_shootings.main() 👌')
    else:
        pass

    if 9 <= this_hour <= 18:
        scheduled_tweets.main()
        print('scheduled_tweets 👌')
    else:
        print('not my tweeting hours')

    print("🍾 Cheers! 🥂🥂🥂")


if __name__ == "__main__":
    requests.get("https://cronhub.io/start/aadb96c0-1e42-11ea-901f-6f28d3f87fc3")
    main()
    requests.get("https://cronhub.io/finish/aadb96c0-1e42-11ea-901f-6f28d3f87fc3")
