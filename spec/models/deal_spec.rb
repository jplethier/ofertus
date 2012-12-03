#encoding: UTF-8
require 'spec_helper'

describe Deal do

  shared_examples_for "All Deals" do
    its(:save) { should be_true }
    its(:switched_on?) { should be_true }

    it { should respond_to :city }
    it { should respond_to :user }

    describe "Accessibility" do
      it { should allow_mass_assignment_of(:address) }
      it { should allow_mass_assignment_of(:category) }
      it { should allow_mass_assignment_of(:company) }
      it { should allow_mass_assignment_of(:description) }
      it { should allow_mass_assignment_of(:discount) }
      it { should allow_mass_assignment_of(:end_date) }
      it { should allow_mass_assignment_of(:image_url) }
      it { should allow_mass_assignment_of(:link) }
      it { should allow_mass_assignment_of(:original_link) }
      it { should allow_mass_assignment_of(:price) }
      it { should allow_mass_assignment_of(:real_price) }
      it { should allow_mass_assignment_of(:title) }
    end

    describe "Validations" do
      it { should validate_presence_of :category }
      it { should validate_presence_of :user }
      
      it "should save as national offer when city is nil" do
        deal.city = nil
        deal.save
        deal.reload
        deal.city.name.should == 'Oferta Nacional'
      end

      it { should validate_presence_of :company }
      it { should validate_presence_of :description }

      describe "#end_date" do
        it "should not be before today" do
          deal.end_date = Date.today - 1
          deal.should_not be_valid
        end

        it "could be equal to today" do
          deal.end_date = Date.today
          deal.should be_valid
        end

        it "could be after today" do
          deal.end_date = Date.today + 1
          deal.should be_valid
        end

        it "should be today if nil" do
          deal.end_date = nil
          deal.save
          deal.end_date.day.should == Date.today.day
        end

        it "should save if don't nil" do
          deal.end_date = Date.tomorrow
          deal.save
          deal.end_date.day.should == Date.tomorrow.day
        end
      end

      describe "#link" do
        it { should validate_presence_of(:link) }

        it "should be unique" do
          duplicated_link = FactoryGirl.create(:deal, end_date: Date.tomorrow).link
          deal.link = duplicated_link
          deal.original_link = duplicated_link
          deal.should_not be_valid
        end

        describe "should begin with http:// or https://" do
          it "http://www.ofertus.com.br should be valid" do
            deal.link = "http://www.ofertus.com.br"
            deal.should be_valid
          end

          it "https://www.ofertus.com.br should be valid" do
            deal.link = "https://www.ofertus.com.br"
            deal.should be_valid
          end

          it "www.ofertus.com.br should be invalid" do
            deal.link = "www.ofertus.com.br"
            deal.should have(1).error_on(:link)
          end
        end
      end

      describe "#image_url" do

        it { should_not validate_presence_of(:image_url) }

        describe "should begin with http:// or https://" do
          it "http://www.ofertus.com.br should be valid" do
            deal.image_url = "http://www.ofertus.com.br"
            deal.should be_valid
          end

          it "https://www.ofertus.com.br should be valid" do
            deal.image_url = "https://www.ofertus.com.br"
            deal.should be_valid
          end

          it "www.ofertus.com.br should be invalid" do
            deal.image_url = "www.ofertus.com.br"
            deal.should have(1).error_on(:image_url)
          end
        end
      end

      describe "#title" do
        it { should validate_presence_of(:title) }

        it "should not let a title with more then 255 chars" do
          deal.title = "a"*256
          deal.should_not be_valid
        end
      end

      describe "validations" do
        it "real_price should be greater than price" do
          deal.real_price_mask = "2,00"
          deal.price = "1,00"
          deal.should be_valid
        end
        it "real_price shouldn't be equal to price" do
          deal.real_price_mask = "1,00"
          deal.price_mask = "1,00"
          deal.should_not be_valid
        end
        it "real_price shouldn't be smaller than price" do
          deal.real_price_mask = "1,00"
          deal.price_mask = "2,00"
          deal.should_not be_valid
        end

        it { should validate_presence_of :real_price_mask }
        it { should validate_presence_of :price_mask }
        it { should_not validate_presence_of :discount }
      end
    end
  end

  describe "Deals Offer" do
    let(:deal) { FactoryGirl.build :deal }
    subject { deal }

    before do
      FactoryGirl.create(:city, :name => 'Oferta Nacional', :state => 'Oferta Nacional')
    end

    it_should_behave_like "All Deals"

    describe "Validations" do
      it "should require a price" do
        deal.price_mask = nil
        deal.should_not be_valid
      end

      it "should require a real price" do
        deal.real_price_mask = nil
        deal.should_not be_valid
      end
      describe "#calculate_discount" do
        it "should be calculated on validation" do
          deal.should_receive(:calculate_discount)
          deal.valid?
        end

        it "should calculate the percentage of discount" do
          deal.real_price = 2
          deal.price = 1.5
          deal.calculate_discount

          deal.discount.should == 25
        end

        it "should not calculate if there is no real_price" do
          deal.real_price = nil
          deal.discount = nil
          deal.calculate_discount

          deal.discount.should == nil
        end
      end
    end
  end

  describe "Categories" do
    it "CATEGORIES should return all categories" do
      Deal::CATEGORIES.should =~ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    end

    specify "RESTAURANT: should be equal 1" do
      Deal::CATEGORY_RESTAURANT.should == 1
    end
    
    specify "BEAUTY_AND_HEALTH: should be equal 2" do
      Deal::CATEGORY_BEAUTY_AND_HEALTH.should == 2
    end

    specify "CULTURE: should be equal 3" do
      Deal::CATEGORY_CULTURE.should == 3
    end

    specify "HOME_AND_APPLIANCE: should be equal 4" do
      Deal::CATEGORY_HOME_AND_APPLIANCE.should == 4
    end

    specify "COMPUTER: should be equal 5" do
      Deal::CATEGORY_COMPUTER.should == 5
    end

    specify "CLOTHES: should be equal 6" do
      Deal::CATEGORY_CLOTHES.should == 6
    end

    specify "TRAVEL: should be equal 7" do
      Deal::CATEGORY_TRAVEL.should == 7
    end

    specify "CAR: should be equal 8" do
      Deal::CATEGORY_CAR.should == 8
    end

    specify "OTHER: should be equal 9" do
      Deal::CATEGORY_OTHER.should == 9
    end

    specify "HOME_AND_DECORATION: should be equal 10" do
      Deal::CATEGORY_HOME_AND_DECORATION.should == 10
    end

    specify "ENTERTAINMENT: should be equal 11" do
      Deal::CATEGORY_ENTERTAINMENT.should == 11
    end

    describe "categories dictionary" do

      it "should return CATEGORY_RESTAURANT if we pass 'restaurant' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["restaurant"].should == Deal::CATEGORY_RESTAURANT
      end

      it "should return CATEGORY_BEAUTY_AND_HEALTH if we pass 'beauty_and_health' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["beauty_and_health"].should == Deal::CATEGORY_BEAUTY_AND_HEALTH
      end

      it "should return CATEGORY_CULTURE if we pass 'culture' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["culture"].should == Deal::CATEGORY_CULTURE
      end

      it "should return CATEGORY_HOME_AND_APPLIANCE if we pass 'home_and_appliance' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["home_and_appliance"].should == Deal::CATEGORY_HOME_AND_APPLIANCE
      end

      it "should return CATEGORY_COMPUTER if we pass 'computer' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["computer"].should == Deal::CATEGORY_COMPUTER
      end

      it "should return CATEGORY_CLOTHES if we pass 'clothes' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["clothes"].should == Deal::CATEGORY_CLOTHES
      end

      it "should return CATEGORY_TRAVEL if we pass 'travel' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["travel"].should == Deal::CATEGORY_TRAVEL
      end

      it "should return CATEGORY_CAR if we pass 'car' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["car"].should == Deal::CATEGORY_CAR
      end

      it "should return CATEGORY_OTHER if we pass 'others' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["others"].should == Deal::CATEGORY_OTHER
      end

      it "should return CATEGORY_HOME_AND_DECORATION if we pass 'home_and_decoration' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["home_and_decoration"].should == Deal::CATEGORY_HOME_AND_DECORATION
      end

      it "should return CATEGORY_ENTERTAINMENT if we pass 'entertainment' to the dictionary" do
        Deal::CATEGORIES_DICTIONARY["entertainment"].should == Deal::CATEGORY_ENTERTAINMENT
      end
    end

    describe "i18n" do
      specify "i18n_categories should return all categories' i18n name" do
        categories = []
        Deal::CATEGORIES.each do |id|
          categories << [Deal.i18n_category(id), id]
        end

        Deal.i18n_categories.should =~ categories
      end

      describe "pt-BR" do
        
        specify "RESTAURANT: should be equal 'Alimentação'" do
          Deal.i18n_category(Deal::CATEGORY_RESTAURANT).should == 'Alimentação'
        end

        specify "BEAUTY AND HEALTH: should be equal 'Beleza e Saúde'" do
          Deal.i18n_category(Deal::CATEGORY_BEAUTY_AND_HEALTH).should == 'Beleza e Saúde'
        end

        specify "CULTURE: should be equal 'Livros, Música e Filmes'" do
          Deal.i18n_category(Deal::CATEGORY_CULTURE).should == 'Livros, Músicas e Filmes'
        end

        specify "HOME AND APPLIANCE: should be equal 'Eletrodomésticos'" do
          Deal.i18n_category(Deal::CATEGORY_HOME_AND_APPLIANCE).should == 'Eletrodomésticos'
        end

        specify "COMPUTER: should be equal 'Tecnologia'" do
          Deal.i18n_category(Deal::CATEGORY_COMPUTER).should == 'Tecnologia'
        end

        specify "CLOTHES: should be equal 'Vestuário e Acessórios'" do
          Deal.i18n_category(Deal::CATEGORY_CLOTHES).should == 'Vestuário e Acessórios'
        end

        specify "TRAVEL: should be equal 'Viagens'" do
          Deal.i18n_category(Deal::CATEGORY_TRAVEL).should == 'Viagens'
        end

        specify "CAR: should be equal 'Automotivos'" do
          Deal.i18n_category(Deal::CATEGORY_CAR).should == 'Automotivos'
        end
        
        specify "OTHER: should be equal 'Diversos'" do
          Deal.i18n_category(Deal::CATEGORY_OTHER).should == 'Diversos'
        end

        specify "ENTERTAINMENT: should be equal 'Entretenimento e Lazer'" do
          Deal.i18n_category(Deal::CATEGORY_ENTERTAINMENT).should == 'Entretenimento e Lazer'
        end

        specify "HOME_AND_DECORATION: should be equal 'Casa e Decoração'" do
          Deal.i18n_category(Deal::CATEGORY_HOME_AND_DECORATION).should == 'Casa e Decoração'
        end
      end
    end
  end

  describe 'search queries' do
    let(:deal) { FactoryGirl.build :deal }
    subject { deal }

    it 'by category' do
      deal.category = Deal::CATEGORY_RESTAURANT
      deal.save
      deal.reload
      Deal.by_category(Deal::CATEGORY_RESTAURANT).should == [deal]
      new_deal = FactoryGirl.create(:deal, :category => Deal::CATEGORY_RESTAURANT)
      Deal.by_category(Deal::CATEGORY_RESTAURANT).recent.should == [new_deal, deal]
    end

    it 'by category string' do
      deal.category = Deal::CATEGORY_RESTAURANT
      deal.save
      deal.reload
      Deal.by_category_string('restaurant').should == [deal]
      new_deal = FactoryGirl.create(:deal, :category => Deal::CATEGORY_RESTAURANT)
      Deal.by_category_string('restaurant').recent.should == [new_deal, deal]
    end

    it 'by cities' do
      deal.city = City.all.first
      deal.save
      deal.reload
      Deal.by_cities([deal.city_id]).should == [deal]
      new_deal = FactoryGirl.create(:deal)
      new_deal.city = City.all.second
      new_deal.save
      new_deal.reload
      Deal.by_cities([deal.city_id, new_deal.city_id]).recent.should == [new_deal, deal]
    end

    it 'by link' do
      deal.link = 'http://www.link.com'
      deal.save
      deal.reload
      Deal.by_link('http://www.link.com').should == deal
    end

    it 'search' do
      deal.title = 'oferta'
      deal.description = 'descricao'
      deal.save
      deal.reload
      Deal.search('ofer').should == [deal]
      Deal.search('desc').should == [deal]
      new_deal = FactoryGirl.create(:deal, :description => 'ofelta')
      Deal.search('ofe').recent.should == [new_deal, deal]
    end

    it 'already shared?' do
      new_deal = FactoryGirl.create(:deal, :original_link => deal.original_link)
      new_deal.already_shared?.should be_true
      new_deal = FactoryGirl.create(:deal, :original_link => deal.original_link + '?pacid=lomadee')
      new_deal.already_shared?.should be_true
      new_deal.original_link = 'http://www.novolink.com.br'
      new_deal.already_shared?.should_not be_true
      deal.original_link = 'http://www.ofertus.com.br/deals/titulo'
      deal.already_shared?.should be_true
    end

    it 'discount to percentage' do
      deal.real_price = 100.0
      deal.discount = 50
      deal.discount_to_percentage.should == 50
      deal.real_price = 100.0
      deal.discount = 30
      deal.discount_to_percentage.should == 30
      deal.real_price = 20.0
      deal.discount = 2
      deal.discount_to_percentage.should == 10
    end

    describe 'average' do
      it 'should be nil if deal has no votings' do
        deal.average.should == nil
      end

      it 'should return the number of upvotes / total votes' do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)
        user.up_vote(deal)
        deal.reload
        deal.average.should == 100
        user2.down_vote(deal)
        deal.reload
        deal.average.should == 50
        user3.up_vote(deal)
        deal.reload
        deal.average.should == 66
      end
    end

    describe 'by username and following' do
      let(:deal1) { FactoryGirl.create(:deal) }
      let(:deal2) { FactoryGirl.create(:deal) }

      before do
        deal.save
      end

      it 'should show only the deals from the user if he follow nobody' do
        Deal.by_username_and_following(deal.user.username).should == [deal]
      end

      it 'should show the deals from user and following users' do
        deal.user.follow! deal1.user
        Deal.by_username_and_following(deal.user.username).should == [deal, deal1]
        deal.user.follow! deal2.user
        Deal.by_username_and_following(deal.user.username).should == [deal, deal1, deal2]
      end
    end

    describe 'ofertus top' do
      it 'favourite' do
        deal.ofertus_top = false
        deal.save(:validate => false)
        deal.favourite!
        deal.reload
        deal.ofertus_top.should == true
      end

      it 'unfavourite' do
        deal.ofertus_top = true
        deal.save(:validate => false)
        deal.unfavourite!
        deal.reload
        deal.ofertus_top.should == false
      end
    end
  end

  describe "affiliate" do
    let(:deal) { FactoryGirl.build :deal }
    subject { deal }
    
    it "compra facil links should have '&a_aid=OfertuSCF'" do
      deal.link = "http://www.comprafacil.com.br/comprafacil/Produto.jsf?VP=2883,1237,1237,1237,49169"
      deal.save
      deal.reload
      deal.link.should match(/&a_aid=OfertuSCF$/)
    end

    it "livraria cultura links should be like http://www.livrariacultura.com.br/scripts/cultura/externo/index.asp?id_link=9151&tipo=25&nitem=XXXXXXXXXX" do
      deal.link = "http://www.livrariacultura.com.br/scripts/resenha/resenha.asp?nitem=29279542&sid=7118122301433468644999511"
      deal.save
      deal.reload
      deal.link.should match(/^http:\/\/www.livrariacultura.com.br\/scripts\/cultura\/externo\/index.asp\?id_link=9151&tipo=25&nitem=[1234567890]+/)
    end
  end
end
