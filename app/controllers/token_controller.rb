class TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def generate
    #token = ::TwilioCapability.generate(role)
    require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
    account_sid = 'ACc6b076d941741f47e46dfe041bd98eed'
    auth_token  = '4a8218fbf947e1865c470f7e2cb0d70c'
    capability = Twilio::Util::Capability.new account_sid, auth_token

    application_sid = 'APe8d0d923cbbf3438295b635b8837cde1'
    capability.allow_client_outgoing application_sid
	capability.allow_client_incoming role
   token = capability.generate
    render json: { token: token }
  end

  def role
    params[:page] == '/dashboard' ? 'support_agent' : 'customer'
  end
end