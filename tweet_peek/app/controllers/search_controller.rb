class SearchController < ApplicationController

  def results
    ### grab tweets ###
    tweets = Twitter.user_timeline(params[:twitter_handle], {count: 200})

    ### Adds Search To Database ###
    search = Search.find_or_create_by_twitter_handle(params[:twitter_handle])
    search.frequency +=1
    if search.save
      # Good path
    else
      redirect_to '/', notice: "Bad search"
      # Bad path, re-render your index view. Send it an error.
    end

    list_of_tweets = []

    ### put text in array separated by space ###
      tweets.each do |tweet|
        list_of_tweets << tweet[:text] + " "
      end

    @tweet_text_hash = {}
    list_of_tweets.each do |words|
      all_words = words.split(' ')

    ### downcasing all words ###
    all_words.map! {|word| word.downcase.strip}

    ### Removing useless words ###
    useless_words =["the", "rt", "in", "of", "to", "and",
                              "a","for", "on", "is", "by", "with", "its",
                              "it's", "it", "at", "your", "you", "are",
                              "have", "has", "this", "that", "be", "from",
                              "an", "as", "their", "there", "they're", "was",
                              "then", "than", "had", "-", "—", "+", "&amp;",
                              "via"
                            ]

    useful_words = all_words - useless_words

    ### Iterating Through useful words
        useful_words.each do |unique_word|
          if @tweet_text_hash[unique_word]
             @tweet_text_hash[unique_word] += 1
          else
             @tweet_text_hash[unique_word] = 1
          end
        end
    end

    @tweet_text_hash = @tweet_text_hash.sort_by {|word, count|  count}
    @tweet_text_hash.reverse!

    @hashtags = @tweet_text_hash.select{|word, frequency| word.include?("#")}
    @tweet_ats = @tweet_text_hash.select{|word, frequency| word.include?("@")}
    @tweet_ats

    ### basic user info ###
    user_information = Twitter.user(params[:twitter_handle])
    @name = user_information[:name]
    @description = user_information[:description]
    @followers = user_information[:followers_count]
    @following = user_information[:friends_count]

  end

  def top_ten
    searches = Search.all
    @popular_search_hash= {}

      #Hash of search results (key = search, value = frequency)
      searches.each do |search|
        @popular_search_hash[search.twitter_handle] = search.frequency
      end

      #Order by most frequent
      @popular_search_hash = @popular_search_hash.sort_by {|search, frequency|  frequency}
      @popular_search_hash.reverse!


  end

end
