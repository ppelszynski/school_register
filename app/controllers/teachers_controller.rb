class TeachersController < ApplicationController
  before_action :admin_required

  def index
    @teachers = User.with_role(:teacher, school)
  end

  def new
    @form = TeacherForm.new
  end

  def create
    set_password

    @form = TeacherForm.new(User.new, params[:user])
    teacher = @form.resource

    User.transaction do
      if @form.save
        TeacherMailer.confirmation_email(teacher, school).deliver
        teacher.confirmed_at = nil

        teacher.add_role(:teacher, school)

        flash[:success] = I18n.t 'notifications.invitation_sent'
        redirect_to school_teachers_path
      else
        flash.now[:error] = I18n.t 'notifications.invitation_not_sent'
        render :new
      end
    end
  end

  private

  def admin_required
    authorize school
  end

  def set_password
    password = Devise.friendly_token.first 8

    params[:user][:password] = password
    params[:user][:password_confirmation] = password
  end

  def school
    current_user.schools.find(params[:school_id])
  end
end
