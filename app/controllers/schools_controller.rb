class SchoolsController < ApplicationController
  def new
    @form = SchoolForm.new
  end

  def create
    authorize School

    @form = SchoolForm.new(current_user.schools.new, params[:school])

    if @form.save
      flash[:success] = I18n.t 'notifications.school_created'
      redirect_to schools_path
    else
      render :new
      flash[:error] = I18n.t 'notifications.edit_not_successful'
    end
  end

  def index
    authorize School

    @schools = policy_scope(School)
  end

  def show
    authorize school
  end

  def edit
    authorize school
    @form = SchoolForm.new(school)
  end

  def update
    authorize school

    @form = SchoolForm.new(school, params[:school])

    if @form.save
      flash[:success] = I18n.t 'notifications.edit_successful'
      redirect_to school
    else
      render :edit
    end
  end

  def destroy
    authorize school
    if school.destroy
      flash[:success] = I18n.t 'notifications.school_deleted'
      redirect_to schools_path
    else
      render :show
    end
  end

  private

  def school
    @school ||= School.find(params[:id])
  end
end
