class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if current_user.blank? 
      login_or_register_user(env['omniauth.auth'])
    else
      flash[:notice] = "Facebook Successfully Connected"
      redirect_to root_path
    end
  end
  
  def twitter
    if current_user.blank? 
      login_or_register_user(env['omniauth.auth'])
    else
      flash[:notice] = "Twitter Successfully Connected"
      redirect_to root_path
    end
  end
  

  protected
  
  def login_or_register_user(auth)
    user = User.find_user_auth(auth)
    if user && user.persisted?
      flash[:notice] = t('devise.omniauth_callbacks.success', :kind => auth['provider'])
    else
      user = register_user(auth)
    end
    sign_in user if user.present?
    redirect_to root_path
  end

  def register_user(auth)
    params = to_hash(auth)
    user = User.new(params[:user])
    if user.save!
      user.linked_networks.new(params[:linked_network]).save
      user
    else
      flash[:notice] = user.errors.full_messages.join(", ")
      return nil
    end
  end

  def to_hash(params)
    if params['provider'] == 'facebook'
      user_info = params['user_info']
      hash = {:user => {:username => user_info['nickname'], :email => user_info['email'], :first_name => user_info['first_name'],
              :last_name => user_info['last_name'], :password => "password"}, 
            :linked_network => {:uid => params['uid'], :provider => params['provider'],  :access_token => params['credentials']['token']}}
    else
      user_info =  params['extra']['user_hash']
      hash = {:user => {:username => user_info['screen_name'], :first_name => user_info['name'], :password => "password"}, 
            :linked_network => {:uid => user_info['id'], :provider => params['provider'],  :access_token => params['credentials']['token']}}
    end
  end
  
end