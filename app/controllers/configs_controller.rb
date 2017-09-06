require 'digest/md5'

class ConfigsController < ApplicationController
  skip_before_action :check_auth, only: [:login]

  def login
    password = params[:password]
    if password == Digest::MD5.hexdigest(Config.getValue('pwd'))
      model = Model.new(200,'success',Hash[:token => Digest::MD5.hexdigest("#{Config.getValue('pwd')}#{Time.now.month}")])
      render :json =>model
    else
      model = Model.new(300,'密码有误。','')
      render :json =>model
    end
  end

end
