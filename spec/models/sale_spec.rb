# coding: utf-8
require 'spec_helper'

describe Sale do
  let(:sale) { FactoryGirl.build :sale }

  subject { sale }

  its(:save) { should be_true }
  its(:switched_on?) { should be_true }

  it { should respond_to :products }
  it { should respond_to :user }

  describe "Accessibility" do
    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:commission) }
    it { should allow_mass_assignment_of(:user_commission) }
    it { should allow_mass_assignment_of(:value) }
  end

  describe "Validations" do
    it { should validate_presence_of(:commission) }
    it { should validate_presence_of(:user_commission) }
    it { should validate_numericality_of(:value) }
  end

  describe "Associations" do
    it { should have_many(:products) }
    it { should belong_to(:user) }
  end

  describe 'Calculations' do
    describe 'lomadee sales' do
      it 'should require a value' do
        params = { :controller_name => 'application', :action_name => 'lomadee', :id_pedido => '111', :id_programa => '4', :pais => 'BR', :mdasc => '1', :desc1 => 'descricao produto 1', :valor1 => '55.50', :desc2 => 'descricao produto 2', :valor2 => '54.61'}
        sale = Sale.register_lomadee(params)
        sale.should == { :error => 'Parâmetro total não enviado' }
      end

      it 'should create a new sale' do
        count = Sale.count
        params = { :controller_name => 'application', :action_name => 'lomadee', :total => '110.11', :id_pedido => '111', :id_programa => '4', :pais => 'BR', :mdasc => '1', :desc1 => 'descricao produto 1', :valor1 => '55.50', :desc2 => 'descricao produto 2', :valor2 => '54.61'}
        Sale.register_lomadee(params)
        Sale.count.should == (count + 1)
        sale = Sale.last
        sale.value.should == 110.11
      end
    end
  end
end
