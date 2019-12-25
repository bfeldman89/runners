# !/usr/bin/env python3
"""
This module runs all of my scripts that require pdfkit bc pythonanywhere doesn't support it.
It is scheduled to run every hour at 5min past the hour. The cron job is as follows:

5 * * * * source ~/.bash_profile && cd ~/code && python3 ~/code/runners/local_sched.py
"""
import os
import time
from datetime import datetime

this_hour = int(time.strftime("%H"))


def csv_log(msg):
    with open('/Users/blakefeldman/code/local_sched.csv', 'a') as log_csv:
        print(datetime.now().strftime('%m/%d/%Y %H:%M'), msg, sep=",", end="\n", file=log_csv)


def main():
    os.chdir(f"/{os.getenv('HOME')}/code/jail_scrapers")
    import pdf_stuff
    pdf_stuff.main()
    csv_log(msg='pdf_stuff.main() 👌')

    if 7 <= this_hour <= 19:
        os.chdir(f"/{os.getenv('HOME')}/code/msleg_scraper/output/diffs")
        import msleg_scraper
        msleg_scraper.main()
        csv_log(msg='msleg_scraper.main() 👌')
    elif this_hour == 2:
        os.chdir(f"/{os.getenv('HOME')}/code/jail_scrapers")
        import snapshot
        snapshot.main()
        csv_log(msg='mdoc_scraper.main() 👌')
    else:
        pass

    csv_log(msg="🍾 Cheers! 🥂🥂🥂")


if __name__ == "__main__":
    main()
