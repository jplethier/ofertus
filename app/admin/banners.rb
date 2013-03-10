#coding: utf-8
ActiveAdmin.register Banner do
  form do |f|
    f.inputs "Banner" do
      f.input :title, hint: 'texto que aparecerá quando o usuário parar o mouse em cima da imagem'
      f.input :alt, hint: 'texto que aparecerá no lugar da figura quando não for possível exibir a figura'
      f.input :target, hint: "'_blank' para abrir numa nova aba, '' para abrir na mesma aba"
      f.input :url, hint: 'url que abrirá ao clicar na imagem'
      f.input :active, label: "Ativo?"
      f.input :image, as: :file, hint: (f.object.image ? f.template.image_tag(f.object.image(:thumb)) : '')
    end
    f.buttons
  end

  index do
    column :image do |banner|
      image_tag banner.image(:thumb)
    end
    column :url do |banner|
      link_to banner.url, banner.url, target: '_blank'
    end
    column :title
    column :alt
    column :target
    column :active
    column :created_at
    default_actions
  end
end