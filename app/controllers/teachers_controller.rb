class TeachersController < ApplicationController
  before_action :school_admin_required

  def index
    @teachers = User.with_role(:teacher, school)
  end

  def new
    @form = TeacherForm.new
  end

  def create
    @form = TeacherForm.new(User.new, params[:user])
    teacher = @form.resource

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

  private

  def school_admin_required
    authorize school
  end

  def school
    @school ||= current_user.schools.find(params[:school_id])
  end
end
