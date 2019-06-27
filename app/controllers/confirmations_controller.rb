class ConfirmationsController < ApplicationController
  before_action :get_teacher

  def show
    validate @teacher
    email
    redirect_to
  end

  def update
    @teacher.confirm!
  end

  private

  def get_teacher
    @teacher = User.find_by(email: email)
  end

  def email
    DecryptEmail.call(params[:token])
  end
end
