ActiveAdmin.register User do
  scope :admin_users
  scope :facebook_users

  index do
    column :name
    column :username
    column :email
    column :last_sign_in_at
    column :sign_in_count
    column 'Ofertas' do |user|
      user.deals.count
    end
    column 'Ofertas Ativas' do |user|
      user.deals.active.count
    end
    column 'Vendas' do |user|
      user.sales.count
    end
    column :credit
    default_actions
  end                                 

  filter :name
  filter :username
  filter :email

  # form do |f|
  #   f.inputs "Admin Details" do
  #     f.input :role
  #     f.input :store_name, input_html: { value: f.object.store.name }
  #     f.input :name
  #     f.input :birth_date, as: :string, input_html: { onkeyup: 'mascara(this, data)', maxlength: '10', value: l(f.object.birth_date.to_date) }, required: true
  #     f.input :cpf
  #     f.input :email
  #     f.input :cover_image, as: :file, hint: (f.object.cover_image ? f.template.image_tag(f.object.cover_image.thumb('100x').url) : '')
  #   end
  #   f.buttons
  # end

  show title: :username do |user|
    attributes_table do
      row :avatar_url do
        image_tag(user.facebook_profile_picture ? user.facebook_profile_picture : '')
      end
      row :name
      row :username
      row :email
      row :last_sign_in_at
      row :sign_in_count
      row :credit
      row 'Numero de Ofertas' do
        user.deals.count
      end
      row 'Numero de Ofertas Ativas' do
        user.deals.active.count
      end
      row 'Numero de Seguidores' do
        user.followers.count
      end
      row 'Seguindo' do
        user.following.count
      end
      row 'Vendas' do
        user.sales.count
      end
    end

    active_admin_comments
  end
end