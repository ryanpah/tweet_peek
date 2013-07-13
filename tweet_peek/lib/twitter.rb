module Twitter
  def timeline(username)
    Twitter.user_timeline(username, {count: 200})
  end
end