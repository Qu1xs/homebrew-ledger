require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    
    # Enable when ready!
    #set :show_exceptions, false
    register Sinatra::Flash
  end

  error 400..510 do # Present error page for any unexpected URL.
    @error = response.status
    erb :error
  end

  helpers do
    def logged_in?
      !!session[:user_id] # `!!` converts value to boolean.
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
