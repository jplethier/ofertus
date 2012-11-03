# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121225111977) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "blog_comments", :force => true do |t|
    t.string   "title",        :limit => 50
    t.string   "email"
    t.string   "name"
    t.string   "site"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_post_id"
    t.integer  "user_id"
  end

  create_table "blog_posts", :force => true do |t|
    t.string   "title",           :limit => 150
    t.string   "url"
    t.text     "content"
    t.integer  "number_of_reads",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "state",      :null => false
    t.string   "country",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "cities_users", :id => false, :force => true do |t|
    t.integer "city_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "deals", :force => true do |t|
    t.text     "description",                                                :null => false
    t.text     "link",                                                       :null => false
    t.string   "title",                                                      :null => false
    t.integer  "user_id",                                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.integer  "category",                                                   :null => false
    t.string   "company",                                                    :null => false
    t.decimal  "discount",      :precision => 8, :scale => 2
    t.datetime "end_date"
    t.decimal  "real_price",    :precision => 8, :scale => 2
    t.decimal  "price",         :precision => 8, :scale => 2
    t.integer  "city_id",                                                    :null => false
    t.integer  "up_votes",                                    :default => 0, :null => false
    t.integer  "down_votes",                                  :default => 0, :null => false
    t.string   "image_url"
    t.string   "slug"
    t.boolean  "ofertus_top"
    t.integer  "visits",                                      :default => 0
    t.string   "original_link"
  end

  add_index "deals", ["city_id"], :name => "index_deals_on_city_id"
  add_index "deals", ["slug"], :name => "index_deals_on_slug", :unique => true

  create_table "errors", :force => true do |t|
    t.string   "model_name"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", :force => true do |t|
    t.float    "commission"
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "user_commission"
  end

  create_table "products", :force => true do |t|
    t.string   "description"
    t.string   "category"
    t.integer  "quantity"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sale_id"
  end

  create_table "rails_blog_engine_comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "author_byline"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_ip"
    t.string   "author_user_agent"
    t.boolean  "author_can_post"
    t.string   "referrer"
    t.string   "state"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_blog_engine_comments", ["author_email"], :name => "index_rails_blog_engine_comments_on_author_email"
  add_index "rails_blog_engine_comments", ["post_id"], :name => "index_rails_blog_engine_comments_on_post_id"

  create_table "rails_blog_engine_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.datetime "published_at"
    t.string   "permalink"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "author_byline"
  end

  add_index "rails_blog_engine_posts", ["permalink"], :name => "index_rails_blog_engine_posts_on_permalink"

  create_table "relationships", :force => true do |t|
    t.integer  "followed_id", :null => false
    t.integer  "follower_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.float    "value"
    t.integer  "store"
    t.string   "affiliate"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliate_transaction"
    t.integer  "user_id"
    t.float    "commission"
    t.float    "user_commission"
    t.integer  "status"
    t.integer  "partner_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "email",                                                               :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128,                               :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username",                                                                               :null => false
    t.integer  "up_votes",                                                            :default => 0,     :null => false
    t.integer  "down_votes",                                                          :default => 0,     :null => false
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar_url"
    t.string   "access_token"
    t.boolean  "facebook_share_offer",                                                :default => true,  :null => false
    t.boolean  "facebook_vote_offer",                                                 :default => true,  :null => false
    t.boolean  "facebook_follow_user",                                                :default => true,  :null => false
    t.decimal  "credit",                                :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "admin",                                                               :default => false
    t.integer  "invited_by_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
