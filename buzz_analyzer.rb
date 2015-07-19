require 'twitter'
require 'dotenv'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['API_KEY']
  config.consumer_secret     = ENV['API_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

analyze_ids = ['BuzzFeed', 'BBC', 'justinbieber']
results = {}

analyze_ids.each do |id|
  results["#{id}"] = client.user_timeline("#{id}", include_rts: false, count: 200).sort{|a, b| b.retweet_count <=> a.retweet_count}.map{|tweet| {'retweet' => tweet.retweet_count, 'description' => tweet.text, 'tweeted_at' => tweet.created_at, 'url' => "https://twitter.com/#{id}/status/#{tweet.id}"}}
end

results.each do |key, values|
  puts key
  values.each do |result|
    puts result
  end
end
