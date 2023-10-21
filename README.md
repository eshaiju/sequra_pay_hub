# SeQuraPayHub

SeQuraPayHub is a modular Ruby on Rails API-only application designed to automate the calculation of merchants' disbursements payouts and seQura commissions. This system ensures that all orders are disbursed precisely once, commissions are calculated accurately, and monthly fees are tracked.

### Implementation:
The service is built as a Ruby on Rails API, utilizing a PostgreSQL database to store merchant data, order information, and financial records. Background jobs and scheduling are efficiently managed using Sidekiq, and a scheduler is employed for task automation. The testing process is conducted with RSpec, ensuring code quality. Continuous integration is achieved through GitHub Actions, streamlining the development and deployment workflow.

### Trade-offs:
The Disbursement generator worker, scheduled to run in the background every day at 8:00 UTC, is responsible for finding the eligible Merchants for disbursements on that day. The implementation considers all the orders from the previous day and the orders from the day six days before to include all the data to be processed that day for the weekly frequency merchants. This setup ensures that all relevant orders are processed when calculating disbursements.

It's worth noting that I commented out some of the RuboCop rules due to time constraints during the development process.

### Future improvements
In the future, we can make enhancements by:
 - Enhance Database Performance with Additional Indexes.
 - Implement Currency Management: (simple currency column in orders, disbursemnts, monthly_fee tables will be enough)
 - Enhance Logging for ETL and Recurring Jobs

### How to run the project

Clone the repository:

   ```sh
   git clone git@github.com:eshaiju/sequra_pay_hub.git
   ```

Install gems using Bundler:

   ```sh
   bundle install
   ```

Prepare the database for local testing:

   ```sh
   rake db:create
   rake db:migrate
   ```

Start Redis after installing redis:

   ```sh
   redis-server

   ```

Start Sidekiq:

   ```sh
   bundle exec sidekiq

   ```

To import merchants and orders from the CSV files, execute:

   ```sh
   rake import:merchants_and_orders
   ```

To create disbursements and monthly fees which are related with imported on previous step merchants and orders, run

```sh
 rake create_disbursements_for_historical_data
 rake create_monthly_fee_for_historical_data
```

To import merchants and orders from the CSV files not added to project data folder, execute:

```sh
  rake 'import:merchants[~/some path /merchants.csv]'
  rake 'import:orders[~/some path /orders.csv]'
```

To get the disbursement summary by the years, run
```sh
  rake 'disbursement_summary:calculate[2022]'
  rake 'disbursement_summary:calculate[2023]'
```

Information about jobs stats and scheduling should be available on sidekiq logs
```
% bundle exec sidekiq


               m,
               `$b
          .ss,  $$:         .,d$
          `$$P,d$P'    .,md$P"'
           ,$$$$$b/md$$$P^'
         .d$$$$$$/$$$P'
         $$^' `"/$$$'       ____  _     _      _    _
         $:    ',$$:       / ___|(_) __| | ___| | _(_) __ _
         `b     :$$        \___ \| |/ _` |/ _ \ |/ / |/ _` |
                $$:         ___) | | (_| |  __/   <| | (_| |
                $$         |____/|_|\__,_|\___|_|\_\_|\__, |
              .d$$                                       |_|
      

2023-10-21T15:48:43.373Z pid=20351 tid=cxb INFO: Booted Rails 7.0.8 application in development environment
2023-10-21T15:48:43.373Z pid=20351 tid=cxb INFO: Running in ruby 3.1.4p223 (2023-03-30 revision 957bb7cb81) [x86_64-darwin23]
2023-10-21T15:48:43.373Z pid=20351 tid=cxb INFO: See LICENSE and the LGPL-3.0 for licensing details.
2023-10-21T15:48:43.373Z pid=20351 tid=cxb INFO: Upgrade to Sidekiq Pro for more features and support: https://sidekiq.org
2023-10-21T15:48:43.373Z pid=20351 tid=cxb INFO: Sidekiq 7.1.6 connecting to Redis with options {:size=>10, :pool_name=>"internal", :url=>"redis://localhost:6379/0"}
2023-10-21T15:48:43.376Z pid=20351 tid=cxb INFO: Sidekiq 7.1.6 connecting to Redis with options {:size=>5, :pool_name=>"default", :url=>"redis://localhost:6379/0"}
2023-10-21T15:48:43.377Z pid=20351 tid=cxb INFO: Loading Schedule
2023-10-21T15:48:43.377Z pid=20351 tid=cxb INFO: Schedule empty! Set Sidekiq.schedule
2023-10-21T15:48:43.377Z pid=20351 tid=cxb INFO: Schedules Loaded
2023-10-21T15:48:43.380Z pid=20351 tid=cxb INFO: Reloading Schedule
2023-10-21T15:48:43.380Z pid=20351 tid=cxb INFO: Loading Schedule
2023-10-21T15:48:43.380Z pid=20351 tid=cxb INFO: Scheduling calculate_monthly_fee_job {"cron"=>"0 0 1 * *", "class"=>"CreateMonthlyFeesJob", "args"=>[nil], "queue"=>"default", "description"=>"Calculate monthly fees for the previous month at the beginning of each month"}
2023-10-21T15:48:43.386Z pid=20351 tid=cxb INFO: Scheduling create_disbursements_job {"cron"=>"0 8 * * *", "class"=>"CreateDisbursementsJob", "args"=>[nil], "queue"=>"default", "description"=>"Create disbursements for eligible merchants by 8:00 AM UTC"}
2023-10-21T15:48:43.387Z pid=20351 tid=cxb INFO: Schedules Loaded

```

Run the RSpec tests:

   ```sh
   bundle exec rspec
   ```


| YEAR | Number of disbursements | Amount disbursed to merchants	| Amount of order fees | Number of monthly fees charged | Amount of monthly fee charged |
|------|-------------------------|--------------------------------|----------------------|--------------------------------|-------------------------------|
| 2022 |          1471           |       17290890.27 €            |   159480.81 €        |          5                      |          78.36 €                     |
| 2023 |           1027           |        19108748.9 €           |    174075.66 €      |                  12              |           200.1 €                    |
|------|-------------------------|--------------------------------|----------------------|--------------------------------|-------------------------------|
