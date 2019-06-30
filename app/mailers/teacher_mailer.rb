class TeacherMailer < ActionMailer::Base
  default from: Settings.support_email

  def confirmation_email(user, school)
    @user = user
    @email = user.email
    @school_id = school.id

    mail(to: @user.email, subject: 'Confirm your email')
  end
end
