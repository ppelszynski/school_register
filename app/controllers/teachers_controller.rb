class TeachersController < ApplicationController
  def index
    @teachers = User.with_role(:teacher, school)
  end

  def new
    @form = TeacherCreateForm.new
  end

  def create
    set_password

    @form = TeacherCreateForm.new(User.new, params[:user])

    if @form.save
      flash[:success] = 'Invitation sent.'
      redirect_to school_teachers_path
      @form.teacher.add_role(:teacher, school)
    else
      flash.now[:error] = 'Invitation not sent.'
      render :new
    end
  end

  private

  def set_password
    password = Devise.friendly_token.first 8

    params[:user][:password] = password
    params[:user][:password_confirmation] = password
  end

  def school
    current_user.schools.find(params[:school_id])
  end
end
