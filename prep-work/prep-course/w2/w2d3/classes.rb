
class Student

  attr_reader :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def course_load
    course_hash = Hash.new(0)
    @courses.each { |course| course_hash[course.department] += course.credits }
    course_hash
  end

  def enroll(course)
    check_for_conflicts(course)

    @courses << course
    course.add_student(self)
  end

  def check_for_conflicts(course)
    raise "Already enrolled in course" if currently_enrolled?(course)
    raise "Has time conflict" if has_time_conflict?(course)
  end

  private

    def has_time_conflict?(course)
      @courses.any? { |current_course| course.conflicts_with?(current_course) }
    end

    def currently_enrolled?(course)
      @courses.include?(course)
    end

end


class Course

  attr_reader :students, :department, :credits, :time_block, :days_of_week

  def initialize(name, department, credits, time_block, days_of_week)
    @name = name
    @department = department
    @credits = credits
    @time_block = time_block
    @days_of_week = days_of_week
    @students = []
  end

  def add_student(student)
    @students << student
  end

  def conflicts_with?(other_course)
    if self.time_block == other_course.time_block
      self.days_of_week.each do |first_class_day|
        other_course.days_of_week.each do |second_class_day|
          return true if first_class_day == second_class_day
        end
      end
    end
    false
  end

end
