class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @bio = student_hash[:bio]

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.map do |s|
      Student.new(s)
    end
  end

  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash[:twitter]
    self.github = attributes_hash[:github]
    self.linkedin = attributes_hash[:linkedin]
    self.bio = attributes_hash[:bio]
    self.profile_quote = attributes_hash[:profile_quote]
    self.blog = attributes_hash[:blog]
    self
  end

  def self.all
    @@all
  end
end
