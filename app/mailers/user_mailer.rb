class UserMailer < ActionMailer::Base
  add_template_helper(ResumesHelper)
  default from: "#{ENV['EMAIL_SENDER_ADDRESS'] || 'dev@artistmagnet.com'}"

  def welcome_email(user,password)
    @user = user
    @password  = password
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def email_resume(user,resume)
  	@user = user
    @resume  = resume
    mail(to: @user.email, subject: 'Your Resume')
  end
end
