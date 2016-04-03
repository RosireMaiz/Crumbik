class TwilioCapability
  def self.generate(role)
    # To find TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN visit
    # https://www.twilio.com/user/account
    account_sid = 'ACc6b076d941741f47e46dfe041bd98eed'
    auth_token  = '4a8218fbf947e1865c470f7e2cb0d70c'
    capability = Twilio::Util::Capability.new account_sid, auth_token

    application_sid = 'APe8d0d923cbbf3438295b635b8837cde1'
    capability.allow_client_outgoing application_sid
    capability.allow_client_incoming role

    capability.generate
  end
end
