#This is the Main Controller. Every Other Controller inherits from this controller.
class ApplicationController < ActionController::Base
  before_action :authenticate_request # every request has to be authenitcated unless explicitly set otherwise.
  skip_before_action :verify_authenticity_token # skip the default csfr thing.
  attr_reader :current_user

  private

  # This is the method that calls the authentication for the requests to the API.
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end