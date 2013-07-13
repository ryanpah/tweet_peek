class SearchController < ApplicationController

  def results
    ### grab tweets ###
    tweets = Twitter.user_timeline(params[:twitter_handle], {count: 200})
    Search.new(params[:twitter_handle])
    list_of_tweets = []

    ### put text in array separated by space ###
      tweets.each do |tweet|
        list_of_tweets << tweet[:text] + " "
      end

    @tweet_text_hash = {}
    list_of_tweets.each do |words|
      word = words.split(' ')
      word.each do |unique_word|
        if @tweet_text_hash[unique_word]
           @tweet_text_hash[unique_word] += 1
        else
           @tweet_text_hash[unique_word] = 1
        end
      end
    end

    @tweet_text_hash = @tweet_text_hash.sort_by {|word, count|  count}
    @tweet_text_hash.reverse!

  end
end
