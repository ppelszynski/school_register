class ConfirmationsController < ApplicationController
  before_action :get_teacher

  def edit
    sign_out
    authorize @teacher, :set_password?

    @form = ConfirmationForm.new @teacher
  end

  def update
    authorize @teacher, :confirm?

    @form = ConfirmationForm.new(@teacher, params[:user])

    if @form.save
      flash[:success] = 'Your email adress has been successfully confirmed.'
      redirect_to new_user_session_path
    end
  end

  private

  def get_teacher
    @teacher ||= User.find_by(email: email)
    binding.pry
  end

  def email
    DecryptEmail.call(params[:token]).result
  end

  def validate_confirmation; end
end
