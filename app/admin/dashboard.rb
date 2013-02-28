#coding: utf-8
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel 'Lista de Emails', :style => 'max-width: 500px; word-wrap: break-word;'  do
          text_area_tag :mail_list, User.email_list.to_s, style: 'width: 97%; height: 300px;'
        end
      end

      column do
        panel 'Estatísticas' do
          render 'statistics'
        end
        panel 'Usuarios que mais venderam esse mês' do
          render 'users_sales_rank', date: Date.today
        end
        panel 'Usuarios que mais venderam no mês passado' do
          render 'users_sales_rank', date: Date.today - 1.month
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
