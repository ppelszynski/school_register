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
    teacher = @form.teacher

    User.transaction do
      if @form.save && SendEmailJob.perform_now(teacher, school)
        teacher.confirmed_at = nil

        teacher.add_role(:teacher, school)

        flash[:success] = 'Invitation sent.'
        redirect_to school_teachers_path
      else
        flash.now[:error] = 'Invitation not sent.'
        render :new
      end
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
