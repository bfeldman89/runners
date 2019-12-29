# runners

## schedule

to run this script, `pa_hourly_runs.sh` is set up as an hourly task on pythonanywhere.

```
05 * * * * source ~/.bashrc && cd ~/code/runners && ./pa_hourly_runs.sh
```


I have to locally run scrapers that require pdfkit, and I'm doing that via `local_hourly_runs.sh`. More specifically, `local_hourly_runs.sh` is scheduled to run ever hour at 40 minutes past the hour via a cron job on my Macbook.

```
40 * * * * source ~/.bash_profile && cd ~/code/runners && ./local_hourly_runs.sh
```
