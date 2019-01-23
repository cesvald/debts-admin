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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190123160538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreement_payments", force: :cascade do |t|
    t.integer  "state",               default: 0
    t.string   "comment"
    t.decimal  "amount"
    t.date     "started_at"
    t.date     "expired_at"
    t.decimal  "amount_debt"
    t.decimal  "total_debt",          default: 0.0
    t.decimal  "total_payment",       default: 0.0
    t.integer  "headquarter_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "last_agreement_date"
    t.integer  "user_id"
  end

  add_index "agreement_payments", ["headquarter_id"], name: "index_agreement_payments_on_headquarter_id", using: :btree
  add_index "agreement_payments", ["user_id"], name: "index_agreement_payments_on_user_id", using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audios", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "length"
    t.string   "wave",          limit: 255
    t.string   "track",         limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_download",              default: true
    t.date     "issued_at"
    t.integer  "level_id"
    t.integer  "list_id"
    t.integer  "audiable_id"
    t.string   "audiable_type"
    t.integer  "number",                    default: 0
  end

  add_index "audios", ["audiable_type", "audiable_id"], name: "index_audios_on_audiable_type_and_audiable_id", using: :btree
  add_index "audios", ["level_id"], name: "index_audios_on_level_id", using: :btree
  add_index "audios", ["list_id"], name: "index_audios_on_list_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "key_prefix",     limit: 255
    t.text     "description"
    t.integer  "authority_id"
    t.string   "authority_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "published_at"
    t.string   "digital"
    t.integer  "level_id"
    t.string   "cover"
    t.string   "author"
    t.integer  "place",                      default: 0
  end

  add_index "books", ["authority_id", "authority_type"], name: "index_books_on_authority_id_and_authority_type", using: :btree
  add_index "books", ["level_id"], name: "index_books_on_level_id", using: :btree
  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "carts", force: :cascade do |t|
    t.date     "purchased_at"
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "chapters", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "start_page"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapters", ["section_id"], name: "index_chapters_on_section_id", using: :btree
  add_index "chapters", ["start_page"], name: "index_chapters_on_start_page", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "configurations", force: :cascade do |t|
    t.text     "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debt_periods", force: :cascade do |t|
    t.decimal  "amount",          default: 0.0
    t.date     "started_at"
    t.integer  "monthly_debt_id"
    t.integer  "months",          default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "debt_periods", ["monthly_debt_id"], name: "index_debt_periods_on_monthly_debt_id", using: :btree

  create_table "debts", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "comment"
    t.boolean  "covered",       default: false
    t.date     "registered_at"
    t.integer  "debable_id"
    t.string   "debable_type"
    t.integer  "item_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "debts", ["debable_type", "debable_id"], name: "index_debts_on_debable_type_and_debable_id", using: :btree
  add_index "debts", ["item_id"], name: "index_debts_on_item_id", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "comment"
    t.date     "registered_at"
    t.integer  "discountable_id"
    t.string   "discountable_type"
    t.integer  "headquarter_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "discounts", ["discountable_type", "discountable_id"], name: "index_discounts_on_discountable_type_and_discountable_id", using: :btree
  add_index "discounts", ["headquarter_id"], name: "index_discounts_on_headquarter_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",                        null: false
    t.text     "description",                 null: false
    t.string   "image",                       null: false
    t.date     "life_at",                     null: false
    t.boolean  "visible",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "general_debts", force: :cascade do |t|
    t.decimal  "total_debt",    default: 0.0
    t.decimal  "total_payment", default: 0.0
    t.decimal  "deposit",       default: 0.0
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "general_debts", ["user_id"], name: "index_general_debts_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "headquarter_id"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "is_outside",     default: false
  end

  add_index "groups", ["headquarter_id"], name: "index_groups_on_headquarter_id", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "headquarters", force: :cascade do |t|
    t.string   "name",               limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mailchimp_group_id"
    t.string   "currency",           limit: 3
  end

  create_table "initiations", force: :cascade do |t|
    t.date     "started_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "headquarter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "items", ["headquarter_id"], name: "index_items_on_headquarter_id", using: :btree

  create_table "lesson_audios", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "audio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lesson_audios", ["audio_id"], name: "index_lesson_audios_on_audio_id", using: :btree
  add_index "lesson_audios", ["lesson_id"], name: "index_lesson_audios_on_lesson_id", using: :btree

  create_table "lesson_levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_videos", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lesson_videos", ["lesson_id"], name: "index_lesson_videos_on_lesson_id", using: :btree
  add_index "lesson_videos", ["video_id"], name: "index_lesson_videos_on_video_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description"
    t.integer  "number_level"
    t.integer  "number"
    t.integer  "lesson_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["lesson_level_id"], name: "index_lessons_on_lesson_level_id", using: :btree

  create_table "level_audios", force: :cascade do |t|
    t.integer  "level_id"
    t.integer  "audio_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "level_audios", ["audio_id"], name: "index_level_audios_on_audio_id", using: :btree
  add_index "level_audios", ["level_id"], name: "index_level_audios_on_level_id", using: :btree

  create_table "level_videos", force: :cascade do |t|
    t.integer  "level_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "number"
    t.integer  "importance"
  end

  add_index "level_videos", ["level_id"], name: "index_level_videos_on_level_id", using: :btree
  add_index "level_videos", ["video_id"], name: "index_level_videos_on_video_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.text     "key"
  end

  create_table "levels_users", id: false, force: :cascade do |t|
    t.integer "id",       default: "nextval('levels_users_id_seq'::regclass)", null: false
    t.integer "level_id"
    t.integer "user_id"
  end

  add_index "levels_users", ["level_id"], name: "index_levels_users_on_level_id", using: :btree
  add_index "levels_users", ["user_id"], name: "index_levels_users_on_user_id", using: :btree

  create_table "live_links", force: :cascade do |t|
    t.text     "url"
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "lesson_id"
  end

  add_index "live_links", ["lesson_id"], name: "index_live_links_on_lesson_id", using: :btree

  create_table "main_pages", force: :cascade do |t|
    t.integer  "level_id"
    t.string   "title"
    t.integer  "start_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "main_pages", ["level_id"], name: "index_main_pages_on_level_id", using: :btree

  create_table "monthly_debts", force: :cascade do |t|
    t.decimal  "total_payment", default: 0.0
    t.decimal  "deposit",       default: 0.0
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "monthly_debts", ["user_id"], name: "index_monthly_debts_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "description"
    t.string   "media",              limit: 255
    t.text     "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_content_trigger"
    t.string   "content_type"
    t.string   "link_label"
  end

  add_index "notifications", ["start_date"], name: "index_notifications_on_start_date", using: :btree

  create_table "pay_periods", force: :cascade do |t|
    t.decimal  "amount"
    t.date     "started_at"
    t.date     "paid_at"
    t.integer  "debt_period_id"
    t.integer  "monthly_debt_id"
    t.integer  "months"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "comment"
  end

  add_index "pay_periods", ["debt_period_id"], name: "index_pay_periods_on_debt_period_id", using: :btree
  add_index "pay_periods", ["monthly_debt_id"], name: "index_pay_periods_on_monthly_debt_id", using: :btree

  create_table "payment_notifications", force: :cascade do |t|
    t.text    "params",         null: false
    t.integer "cart_id",        null: false
    t.string  "status",         null: false
    t.string  "transaction_id", null: false
  end

  add_index "payment_notifications", ["cart_id"], name: "index_payment_notifications_on_cart_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "paid_at"
    t.decimal  "amount"
    t.string   "method"
    t.string   "comment"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.integer  "headquarter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "payments", ["headquarter_id"], name: "index_payments_on_headquarter_id", using: :btree
  add_index "payments", ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.text     "description"
    t.string   "image",       limit: 255
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.decimal  "price",            null: false
    t.string   "purchasable_type", null: false
    t.integer  "purchasable_id",   null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "products_users", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
  end

  add_index "products_users", ["product_id"], name: "index_products_users_on_product_id", using: :btree
  add_index "products_users", ["user_id"], name: "index_products_users_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", force: :cascade do |t|
    t.integer "book_id"
    t.integer "start_page"
    t.integer "end_page"
    t.string  "name"
    t.boolean "visible"
  end

  add_index "publications", ["book_id"], name: "index_publications_on_book_id", using: :btree

  create_table "quota", force: :cascade do |t|
    t.integer  "agreement_payment_id"
    t.decimal  "amount"
    t.date     "expected_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "quota", ["agreement_payment_id"], name: "index_quota_on_agreement_payment_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["profile_id"], name: "index_roles_on_profile_id", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "start_page"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main_number"
  end

  add_index "sections", ["book_id"], name: "index_sections_on_book_id", using: :btree
  add_index "sections", ["start_page"], name: "index_sections_on_start_page", using: :btree

  create_table "suspensions", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "start_at",   null: false
    t.date     "end_at"
    t.string   "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "suspensions", ["user_id"], name: "index_suspensions_on_user_id", using: :btree

  create_table "swamis", force: :cascade do |t|
    t.string  "name"
    t.integer "year"
    t.integer "user_id"
  end

  add_index "swamis", ["user_id"], name: "index_swamis_on_user_id", using: :btree

  create_table "sync_queues", force: :cascade do |t|
    t.integer "action"
    t.integer "sync_id"
    t.string  "sync_type"
  end

  add_index "sync_queues", ["sync_id", "sync_type"], name: "index_sync_queues_on_sync_id_and_sync_type", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggable_id"
    t.string   "taggable_type"
  end

  add_index "tags", ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",                    null: false
    t.string   "encrypted_password",     limit: 255, default: "",                    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.string   "name",                   limit: 255
    t.string   "surname",                limit: 255
    t.integer  "lesson_id"
    t.integer  "level_id"
    t.boolean  "is_confirmed",                       default: false
    t.integer  "level_two_id"
    t.integer  "group_id"
    t.datetime "notification_date",                  default: '2017-06-17 11:01:35'
    t.boolean  "outside",                            default: false
    t.integer  "group_outside_id"
    t.integer  "status",                             default: 0
    t.integer  "failed_attempts",                    default: 0,                     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "initiation_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["group_outside_id"], name: "index_users_on_group_outside_id", using: :btree
  add_index "users", ["initiation_id"], name: "index_users_on_initiation_id", using: :btree
  add_index "users", ["lesson_id"], name: "index_users_on_lesson_id", using: :btree
  add_index "users", ["level_id"], name: "index_users_on_level_id", using: :btree
  add_index "users", ["level_two_id"], name: "index_users_on_level_two_id", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "length"
    t.string   "cover",         limit: 255
    t.text     "track"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "live_on"
    t.string   "track_type"
    t.integer  "level_id"
    t.integer  "videable_id"
    t.string   "videable_type"
    t.integer  "number",                    default: 0
  end

  add_index "videos", ["level_id"], name: "index_videos_on_level_id", using: :btree
  add_index "videos", ["videable_type", "videable_id"], name: "index_videos_on_videable_type_and_videable_id", using: :btree

  create_table "web_push_subscriptions", force: :cascade do |t|
    t.text    "endpoint"
    t.string  "auth"
    t.string  "p256dh"
    t.integer "user_id"
  end

  add_index "web_push_subscriptions", ["user_id"], name: "index_web_push_subscriptions_on_user_id", using: :btree

  add_foreign_key "agreement_payments", "headquarters"
  add_foreign_key "agreement_payments", "users"
  add_foreign_key "audios", "levels"
  add_foreign_key "books", "levels"
  add_foreign_key "carts", "users"
  add_foreign_key "chapters", "sections", name: "fk_chapters_section_id"
  add_foreign_key "comments", "users", name: "fk_comments_user_id"
  add_foreign_key "debt_periods", "monthly_debts"
  add_foreign_key "debts", "items"
  add_foreign_key "discounts", "headquarters"
  add_foreign_key "general_debts", "users"
  add_foreign_key "groups", "headquarters", on_update: :cascade, on_delete: :cascade
  add_foreign_key "groups", "users", on_update: :cascade, on_delete: :nullify
  add_foreign_key "items", "headquarters"
  add_foreign_key "lesson_audios", "audios"
  add_foreign_key "lesson_audios", "lessons"
  add_foreign_key "lesson_videos", "lessons"
  add_foreign_key "lesson_videos", "videos"
  add_foreign_key "lessons", "lesson_levels", name: "fk_lessons_lesson_level_id"
  add_foreign_key "level_audios", "audios", name: "fk_level_audios_audio_id"
  add_foreign_key "level_audios", "levels", name: "fk_level_audios_level_id"
  add_foreign_key "level_videos", "levels"
  add_foreign_key "level_videos", "videos"
  add_foreign_key "levels_users", "levels"
  add_foreign_key "levels_users", "users"
  add_foreign_key "live_links", "lessons"
  add_foreign_key "main_pages", "levels", on_update: :cascade, on_delete: :cascade
  add_foreign_key "monthly_debts", "users"
  add_foreign_key "pay_periods", "debt_periods"
  add_foreign_key "pay_periods", "monthly_debts"
  add_foreign_key "payment_notifications", "carts"
  add_foreign_key "payments", "headquarters"
  add_foreign_key "photos", "albums", name: "fk_photos_album_id"
  add_foreign_key "products_users", "products"
  add_foreign_key "products_users", "users"
  add_foreign_key "publications", "books"
  add_foreign_key "quota", "agreement_payments"
  add_foreign_key "roles", "profiles", name: "fk_roles_profile_id"
  add_foreign_key "roles", "users", name: "fk_roles_user_id"
  add_foreign_key "sections", "books", name: "fk_sections_book_id"
  add_foreign_key "suspensions", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "swamis", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "groups", column: "group_outside_id"
  add_foreign_key "users", "groups", on_update: :cascade, on_delete: :nullify
  add_foreign_key "users", "initiations"
  add_foreign_key "users", "lessons", name: "fk_users_lesson_id"
  add_foreign_key "users", "levels", column: "level_two_id"
  add_foreign_key "users", "levels", name: "fk_users_level_id"
  add_foreign_key "videos", "levels"
  add_foreign_key "web_push_subscriptions", "users", on_update: :cascade, on_delete: :cascade
end
