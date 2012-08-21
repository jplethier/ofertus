# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Show deal page" do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  let(:deal) { FactoryGirl.create(:deal, :image_url => 'http://www.image.com/image') }
  
  subject { page }

  before do
    deal.save
    visit deal_path(deal)
  end

  after { Warden.test_reset! }

  describe 'deal show page' do
    it { should have_content(deal.title) }
    it { should have_link(deal.title, :href => deal.link) }
    it { should have_content(Deal.i18n_category(deal.category)) }

    it 'should show the deals info' do
      within '#sem-col' do
        should have_css('.ttGlHome h2', :text => Deal.i18n_category(deal.category))
        should have_css('.detalhe-oferta .off .col-off h4', :text => "Preço originalR$ #{deal.real_price.to_s.gsub('.',',')+(deal.real_price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.detalhe-oferta .off .col-off .preco-off h4', :text => "Preço ofertaR$ #{deal.price.to_s.gsub('.',',')+(deal.price.to_s.split('.')[1].size < 2 ? '0' : '')}")
        should have_css('.detalhe-oferta .off .col-off h5', :text => "Desconto #{deal.discount.to_i}%")
        should have_css('.detalhe-oferta .off .col-off h5', :text => "Válida até #{I18n.l(deal.end_date.to_date)}")
        should have_css('.detalhe-oferta .tx-off h3 a', :href => deal.link, :text => deal.title)
        should have_css('.detalhe-oferta .tx-off .user-off a', :href => user_path(deal.user.username))
        should have_css('.detalhe-oferta .tx-off .user-off a img', :src => deal.user.gravatar_url)
        should have_css('.detalhe-oferta .tx-off .user-off span a', :href => user_path(deal.user.username))
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Categoria: #{Deal.i18n_category(deal.category)}")
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Empresa: #{deal.company}")
        should have_css('.detalhe-oferta .tx-off ul li', :text => "Válida para: #{deal.city.name}")
        should have_css('.detalhe-oferta .right img', :src => deal.image_url)
      end
    end

    it 'should show the links to vote if user is logged in' do
      user = FactoryGirl.create(:user)
      user.confirm!
      login_as user, :scope => :user
      visit deal_path(deal)
      should have_css('.detalhe-oferta .share-off span.gostei a', :text => 'Gostei!', :href => upvote_deal_path(deal))
      should have_css('.detalhe-oferta .share-off span.gostei')
      should have_css('.detalhe-oferta .share-off span.nao-gostei')
      should have_css('.detalhe-oferta .share-off span.nao-gostei a', :text => 'Não Gostei!', :href => downvote_deal_path(deal))
    end

    it 'should show the deals description' do
      within '#sem-col .desc-off' do
        should have_css('h4', :text => 'Descrição da Oferta')
        within '.tx-desc' do
          should have_content(deal.description)
        end
      end
    end

    it 'should show the comments' do
      within '#sem-col .right-detalhe-comment-off' do
        should have_content('Comentários')
      end
    end

    it 'should show the comment form if the user is logged in' do
      user = FactoryGirl.create(:user)
      user.confirm!
      login_as user, :scope => :user
      visit deal_path(deal)
      should have_css('textarea#comment_comment')
      should have_css('input.bt-comentar', :typev => 'submit')
    end


    it 'should show the comments' do
      within '#sem-col .right-detalhe-comment-off' do
        should have_content('Comentários')
        should_not have_css('textarea#comment_comment')
        should_not have_css('input.bt-comentar', :typev => 'submit')
      end
    end
  end
end