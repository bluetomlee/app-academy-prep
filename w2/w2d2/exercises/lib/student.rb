class Student
  attr_accessor :first_name, :last_name, :courses

  def initialize( first_name, last_name )
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def enroll( new_course )
    raise if @courses.any?{|course| course.conflicts_with?( new_course )}
    new_course.students << self
    @courses << new_course unless @courses.include?(new_course)
  end

  def course_load
    courses = {}

    @courses.each do |course|
      courses[ course.department ] += course.credits if courses.has_key?( course.department )
      courses[ course.department ] = course.credits unless courses.has_key?( course.department )
    end

    courses
  end
end
