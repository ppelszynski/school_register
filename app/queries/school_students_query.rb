class SchoolStudentsQuery < Patterns::Query
  queries User

  private

  def query
    relation.with_role(:student, :any)
            .joins("INNER JOIN school_classes ON roles.resource_id = school_classes.id AND roles.resource_type = 'SchoolClass'")
            .joins('INNER JOIN schools ON school_classes.school_id = schools.id')
            .where(schools: { id: options.fetch(:school).id })
  end
end
