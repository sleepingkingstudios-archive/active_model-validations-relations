# spec/active_model/validations/relations_spec.rb

require 'active_model/validations/relations'
require 'active_model/validations/relations/serializers/underscore_serializer'

RSpec.describe ActiveModel::Validations::Relations do
  let(:described_class) { Class.new.send(:include, ActiveModel::Validations).send(:include, super()) }

  describe '::validates_relation' do
    it { expect(described_class).to respond_to(:validates_relation).with(1..2).arguments }

    describe 'with :inventor' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::Validations::Relations::One

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :inventor
        end # expect

        described_class.validates_relation :inventor
      end # it
    end # describe

    describe 'with :widgets' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :widgets
        end # expect

        described_class.validates_relation :widgets
      end # it
    end # describe

    describe 'with :sheep, :arity => :one' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::Validations::Relations::One

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :sheep
        end # expect

        described_class.validates_relation :sheep
      end # it
    end # describe

    describe 'with :sheep, :arity => :many' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :sheep
        end # expect

        described_class.validates_relation :sheep, :arity => :many
      end # it
    end # describe

    describe 'with :trolls, :arity => :trololol' do
      it 'raises an error' do
        expect {
          described_class.validates_relation :trolls, :arity => :trololol
        }.to raise_error ArgumentError, /unrecognized arity/
      end # it
    end # describe

    describe 'with :patents, :serializer => UnderscoreSerializer' do
      let(:serializer) { ActiveModel::Validations::Relations::Serializers::UnderscoreSerializer }

      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :patents
          expect(validator.send :serializer).to be == serializer
        end # expect

        described_class.validates_relation :patents, :serializer => serializer
      end # it
    end # describe
  end # describe
end # describe
