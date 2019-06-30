class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, school)
    @user = user
    @school = school

    TeacherMailer.confirmation_email(@user, @school).deliver_now
  end
end
