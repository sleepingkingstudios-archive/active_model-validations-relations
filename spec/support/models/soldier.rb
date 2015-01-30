# spec/support/models/soldier.rb

class Soldier < Struct.new(:rank)
  include ActiveModel::Validations

  attr_accessor :army

  validates :rank, :presence => true
end # class
