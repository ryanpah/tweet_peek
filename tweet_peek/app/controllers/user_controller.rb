class UserController < ApplicationController

  def save
      s = Search.find_by_twitter_handle(params[:twitter_handle])

        unless current_user.searches.include?(s)
          current_user.searches << s
        end
    redirect_to('/twitter/favorites')
  end

  def favorites
    @favorites = current_user.searches
  end




end
