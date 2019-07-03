class SchoolClassesController < ApplicationController
  def new
    authorize school

    @form = SchoolClassForm.new(school.school_classes.new)
  end

  def edit
    @form = SchoolClassForm.new(school_class)
  end

  def show
    authorize school, policy_class: SchoolClassPolicy

    pending_students = User.where(id: school_class.school_applications.map(&:user_id)).without_role(:student, :any)
    @q = pending_students.ransack(params[:q])
    @selected_students = @q.result(distinct: true)

    @students = User.where(id: school_class.school_applications.map(&:user_id))
  end

  def index
    authorize school, policy_class: SchoolClassPolicy

    @classes = school.school_classes
  end

  def create
    authorize school, policy_class: SchoolClassPolicy

    @form = SchoolClassForm.new(school.school_classes.new, params[:school_class])
    if @form.save
      flash[:success] = I18n.t 'notifications.school_class_created'
      redirect_to school_school_classes_path
    else
      render :new
    end
  end

  def update
    authorize school, policy_class: SchoolClassPolicy

    @form = SchoolClassForm.new(school_class, params[:school_class])

    if @form.save
      flash[:success] = I18n.t 'notifications.edit_successful'
      redirect_to school_school_classes_path
    else
      render :edit
    end
  end

  def destroy
    authorize school, policy_class: SchoolClassPolicy

    if school_class.destroy
      flash[:success] = I18n.t 'notifications.school_class_deleted'
      redirect_to school_school_classes_path
    else
      render :show
    end
  end

  private

  def school_class
    @school_class ||= school.school_classes.find(params[:id])
  end

  def school
    @school ||= School.find(params[:school_id])
  end

  def school_application
    @school_application ||= SchoolApplication.find_by(school_class_id: school_class.id)
  end
end
