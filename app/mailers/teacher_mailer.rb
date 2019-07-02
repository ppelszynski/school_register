class TeacherMailer < ActionMailer::Base
  default from: Settings.support_email

  def confirmation_email(user, school)
    @user = user.decorate
    @email = user.email
    @school_id = school.id

    mail(to: @email, subject: 'Confirm your email')
  end
end
