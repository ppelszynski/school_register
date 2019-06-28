class ConfirmationsController < ApplicationController
  before_action :get_teacher

  def edit
    authorize @teacher
  end

  def update
    authorize @teacher
    @teacher.confirm!
  end

  private

  def get_teacher
    binding.pry
    @teacher = User.find_by(email: email)
  end

  def email
    DecryptEmail.call(params[:token]).result
  end
end
