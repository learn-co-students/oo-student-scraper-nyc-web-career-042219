class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def self.all
    @@all
  end

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student_hash| Student.new(student_hash) }
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |attr, val| self.send("#{attr}=", val) }
    self
  end

end

