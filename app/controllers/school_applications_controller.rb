class SchoolApplicationsController < ApplicationController
  def index
    @applications = school.school_applications
  end

  def create
    application = school_class.school_applications.new(user: current_user)

    if application.save
      flash[:success] = I18n.t 'notifications.application_succesful'
    else
      flash[:error] = I18n.t 'notifications.application_error'
    end

    redirect_to school_school_classes_path(school)
  end

  def update
    user = User.find(SchoolApplication.find(params[:id]).user_id)

    if slot_available?
      user.add_role(:student, school_class)
      flash[:success] = I18n.t 'notifications.application_confirmed'
      redirect_to school_school_class_path(school, school_class)
    else
      flash[:error] = I18n.t 'notifications.application_not_confirmed'
      redirect_to school_school_class_path(school, school_class)
    end
  end

  private

  def school
    @school ||= School.find(params[:school_id])
  end

  def school_class
    @school_class ||= SchoolClass.find(params[:school_class_id])
  end

  def slot_available?
    school_class.decorate.free_slots != 0
  end
end
