set :environment, "development"
set :output, { error: 'error.log', standard: 'cron.log' }

every 2.minutes do
  rake "cleanup:delete_old_items"
end