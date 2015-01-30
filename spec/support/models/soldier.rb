# spec/support/models/soldier.rb

class Soldier < Struct.new(:rank)
  include ActiveModel::Validations
  include ActiveModel::Validations::Relations

  attr_accessor :army

  def rations
    @rations ||= []
  end # method rations

  attr_writer :rations

  validates :rank, :presence => true
  validates_relation :rations
end # class
