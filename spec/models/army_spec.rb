# spec/models/army_spec.rb

RSpec.describe Army do
  let(:instance) { described_class.new }

  ### Validation ###
  it { expect(instance).to be_valid }

  describe 'with a valid general' do
    let(:general) { General.new('Croix de Guerre') }

    before(:each) { instance.general = general }

    it { expect(instance).to be_valid }
  end # describe

  describe 'with an invalid general' do
    let(:general) { General.new }
    let(:errors) do
      { :"general[medals]" => ["can't be blank"] }
    end # let

    before(:each) { instance.general = general }

    it { expect(instance).not_to be_valid }

    it 'should merge the relation errors into errors' do
      instance.valid?

      expect(instance.errors.keys).to contain_exactly *errors.keys
      errors.each do |key, messages|
        expect(instance.errors[key]).to contain_exactly *messages
      end # each
    end # it
  end # describe

  describe 'with many valid soldiers' do
    let(:soldiers) { %w(private private leftenant).map { |rank| Soldier.new(rank) } }

    before(:each) { instance.soldiers = soldiers }

    it { expect(instance).to be_valid }
  end # describe

  describe 'with many invalid soldiers' do
    let(:soldiers) { Array.new(3) { Soldier.new } }
    let(:errors) do
      soldiers.each.with_index.with_object({}) do |(_, index), hsh|
        hsh[:"soldiers[#{index}][rank]"] = ["can't be blank"]
      end # each
    end # let

    before(:each) { instance.soldiers = soldiers }

    it { expect(instance).not_to be_valid }

    it 'should merge the relation errors into errors' do
      instance.valid?

      expect(instance.errors.keys).to contain_exactly *errors.keys
      errors.each do |key, messages|
        expect(instance.errors[key]).to contain_exactly *messages
      end # each
    end # it
  end # describe
end # describe
