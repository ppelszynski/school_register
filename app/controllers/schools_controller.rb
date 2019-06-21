class CoursesController < ApplicationController
  def new
    @school = School.new
  end

  def create
    @school = current_user.schools.new(school_params)

    if @school.save!
      redirect_to @school
    else
      render :new
    end
  end

  def index
    @schools = current_user.schools
  end

  def show
    @school = current_user.schools.find(school_id)
  end

  def update
    @school = current_user.schools.find(school_id)

    if @school.update(school_params)
      redirect_to @school
    else
      render :edit
    end
  end

  def destroy
    @school = current_user.schools.find(school_id)

    if @school.update(school_params)
      redirect_to schools_path
    else
      render :edit
    end
  end

  private

  def school_id
    params[:id]
  end

  def school_params
    params.require(:school).permit(:name, :adress, :phone_number, :status)
  end
end
