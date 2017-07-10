# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#set :output, Rails.root + "/log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :output, File.join(File.expand_path('../../log/', __FILE__),'cron.development.log')

#set :environment, "development"

every '*/5 6-15 * * 1-5' do
	runner "EmailsQueue.send_campaign_emails"
end

every 1.day, :at => '00:30 am' do
	runner "Campaign.reset_campaigns_sent_rate"
end