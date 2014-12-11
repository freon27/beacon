class BeaconMailer < ActionMailer::Base
  default :from => 'donotreply@beacon.com'
  
  def request_created_email(user_email, request)
      @user_email = user_email
      @request  = request
      mail(to: User.pluck(:email), subject: "BEACON: #{@user_email} has created request '#{@request.title}'")
  end
  
  def completion_email(current_user, request)
      @request  = request
      mail(to: request.requestor.email, subject: "BEACON: #{current_user} has set request '#{@request.title}' to complete")
  end
end