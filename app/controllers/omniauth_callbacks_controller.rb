class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = ConnectWithOauthProvider.connect(request.env["omniauth.auth"])

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
    sign_in_and_redirect @user, event: :authentication

    # TODO: Handle registration, when new user is authenticating.
    # session["devise.google_data"] = request.env["omniauth.auth"]
    # redirect_to new_user_registration_url
  end
end
