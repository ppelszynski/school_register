class StudentsController < ApplicationController
  def new
    @form = StudentForm.new(User.new)
  end

  def create
    @form = StudentForm.new(User.new, params[:user])
    if @form.save
      flash[:success] = 'A message with a confirmation link has been sent to your email address.'
      redirect_to root_path
    else
      render :new
    end
  end
end
