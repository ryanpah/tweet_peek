class SearchController < ApplicationController
include Twitter
  def search
    @tweets = Twitter.user_timeline('@zreitano', {count: 200})
  end


end
