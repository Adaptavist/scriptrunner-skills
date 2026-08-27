# Scheduled Triggers

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-194675329
- Source: https://docs.adaptavist.com/src/latest/workspaces/scheduled-triggers

Scheduled triggers enable you to execute scripts at a specific time.

## ScriptRunner Connect help or build it yourself

When you create a new scheduled trigger, you'll be asked to provide a schedule in [CRON format](http://www.nncron.ru/help/EN/working/cron-format.htm), as well as a script to trigger it. The ScriptRunner Connect UI helps you follow the correct CRON schedule format. You can use the app's help to construct the CRON expression, build the expression manually, or use the app's guidance to get started and manually tweak the CRON expression to your liking.

## Supported CRON expressions

ScriptRunner Connect currently supports the following six CRON expression segments (image courtesy of [npm](https://www.npmjs.com/package/cron-parser)):

![Cron job syntax diagram showing six fields with asterisks, each labeled: second, minute, hour, day of month, month, day of week.](/src/files/latest/194675329/194675328/1/1695208515000/cron-format-nps.png)

## Timezones

Scripts trigger via the UTC (GMT+0) timezone—something you want to consider when constructing a CRON expression. Next-estimated and last-scheduled-trigger dates are shown in your local time zone based on your OS or browser settings. Use this data to verify that your CRON trigger behaves as you expect.

## Interval minimum

The minimum trigger interval allowed by ScriptRunner Connect is 15 minutes. While you can construct triggers to execute more frequently, the app adjusts so intervals remain, at a minimum, 15 minutes apart.

**A known issue with the scheduler**

When constructing minute-based intervals, we recommend using multiples of 15 minutes, such as every 15 minutes, 30 minutes, 60 minutes, and so on. Departing from these recommendations may lead to the scheduler defaulting to the minimum interval of 15 minutes. 

## Environments

You are allowed to define a different schedule for each of your environments. When creating a new environment, you must set a new schedule for existing scheduled triggers. While these schedules can differ from those in your existing environment(s), they don't have to.

## Deploying scheduled triggers

New scheduled triggers won't be activated until the environment in which it was created is redeployed.
