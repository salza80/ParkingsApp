class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    if session_params[:email] == ''
      login_facebook
      
    else
      login_account
    end
  end

  def failure
    redirect_to login_url, notice: 'Facebook authentication failed.'
  end

  def destroy
    session[:account_id] = ''
    redirect_to login_url, notice: 'You have successfully logged out.'
  end

  private

  def login_account
    account = Account.authenticate(session_params[:email], session_params[:password])
    if account != false
      session[:account_id] = account_id
      redirect_after_login
    else
      log_in_failed
    end
  end
  def redirect_after_login
    if session[:return_to] == login_url || session[:return_to] .nil?
        redirect_to root_url
      else
        redirect_to session[:return_to]
      end
  end

  def login_facebook
    auth_hash = request.env['omniauth.auth']
    facebook_account = FacebookAccount.find_or_create_for_facebook(auth_hash)
    session[:facebook_account_id] = facebook_account.id
    redirect_after_login
  end

  def log_in_failed
    redirect_to login_url, notice: 'Login failed. Incorrect username or password.'
  end

  def session_params
    params.permit(:email, :password)
  end
end
