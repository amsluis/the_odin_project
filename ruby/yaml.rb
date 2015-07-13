require 'yaml'

class Person
  attr_accessor :name, :age
end

norma = Person.new
norma.name, norma.age = "Norma Lou", 33

bob = Person.new
bob.name, bob.age = "Bob Joe", 23

data = [norma, bob]

File.new('yaml.yaml','w').puts(YAML::dump(data))
