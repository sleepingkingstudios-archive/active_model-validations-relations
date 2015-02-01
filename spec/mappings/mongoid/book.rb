# spec/mappings/mongoid/book.rb

require 'active_model/validations/relations'

class Book
  include Mongoid::Document
  include ActiveModel::Validations::Relations

  embeds_one  :preface,  :class_name => 'BookPreface', :validate => false
  embeds_many :chapters, :class_name => 'BookChapter', :validate => false

  validates_related_documents :chapters
  validates_related_documents :preface
end # class
