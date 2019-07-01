class ConfirmationsController < ApplicationController
  def edit
    sign_out
    authorize teacher, :set_password?

    @form = ConfirmationForm.new teacher
  end

  def update
    authorize teacher, :confirm?

    @form = ConfirmationForm.new(teacher, params[:user])

    if @form.save
      flash[:success] = t('notifications.email_confirmed')
      redirect_to new_user_session_path
    end
  end

  private

  def teacher
    @teacher ||= User.find_by(email: email)
  end

  def email
    DecryptEmail.call(params[:token]).result
  end
end
