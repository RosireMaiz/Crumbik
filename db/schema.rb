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

ActiveRecord::Schema.define(version: 20160317031652) do

  create_table "autenticacions", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "autenticacions", ["usuario_id"], name: "index_autenticacions_on_usuario_id", using: :btree

  create_table "campanna_publicitaria", force: :cascade do |t|
    t.string   "titulo",       limit: 255
    t.string   "descripcion",  limit: 255
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.integer  "producto_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "campanna_publicitaria_detalles", force: :cascade do |t|
    t.integer  "medio_difusion",           limit: 4
    t.integer  "campanna_publicitaria_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "campanna_publicitaria_detalles", ["campanna_publicitaria_id"], name: "index_campanna_publicitaria_detalles_on_campanna_publicitaria_id", using: :btree

  create_table "categoria", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.string   "estatus",     limit: 1,   default: "A"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "contratos", force: :cascade do |t|
    t.datetime "fecha_creacion",                null: false
    t.date     "fecha_vencimiento"
    t.string   "estatus",           limit: 255
    t.string   "observacion",       limit: 255
    t.integer  "organizacion_id",   limit: 4
    t.integer  "plan_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "contratos", ["organizacion_id"], name: "index_contratos_on_organizacion_id", using: :btree
  add_index "contratos", ["plan_id"], name: "index_contratos_on_plan_id", using: :btree

  create_table "criterio_campanna_pubs", force: :cascade do |t|
    t.integer  "campanna_publicitaria_id", limit: 4
    t.integer  "criterio_difusion_id",     limit: 4
    t.string   "operador",                 limit: 255
    t.string   "valor",                    limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "criterio_campanna_pubs", ["campanna_publicitaria_id"], name: "index_criterio_campanna_pubs_on_campanna_publicitaria_id", using: :btree
  add_index "criterio_campanna_pubs", ["criterio_difusion_id"], name: "index_criterio_campanna_pubs_on_criterio_difusion_id", using: :btree

  create_table "criterio_difusions", force: :cascade do |t|
    t.string   "nombre",            limit: 255
    t.text     "descripcion",       limit: 65535
    t.string   "campo_seleccion",   limit: 255
    t.string   "tabla",             limit: 255
    t.string   "campo_comparacion", limit: 255
    t.string   "estatus",           limit: 1,     default: "A"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "dispositivos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "eventos", force: :cascade do |t|
    t.string   "titulo",       limit: 255
    t.text     "descripcion",  limit: 65535
    t.string   "url",          limit: 255
    t.string   "color",        limit: 255
    t.boolean  "dia_completo", limit: 1,     default: true, null: false
    t.datetime "inicio"
    t.datetime "fin"
    t.integer  "usuario_id",   limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "eventos", ["usuario_id"], name: "index_eventos_on_usuario_id", using: :btree

  create_table "frecuencia_pagos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.integer  "meses",      limit: 4
    t.string   "estatus",    limit: 1,   default: "A"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "interaccion_campanna_pubs", force: :cascade do |t|
    t.string   "asunto",                limit: 255
    t.string   "contenido",             limit: 255
    t.string   "url",                   limit: 255
    t.binary   "media",                 limit: 4294967295
    t.string   "formato_media",         limit: 255
    t.integer  "campanna_detalle_id",   limit: 4
    t.integer  "usuario_ejercutivo_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "interaccion_campanna_pubs", ["campanna_detalle_id"], name: "index_interaccion_campanna_pubs_on_campanna_detalle_id", using: :btree
  add_index "interaccion_campanna_pubs", ["usuario_ejercutivo_id"], name: "index_interaccion_campanna_pubs_on_usuario_ejercutivo_id", using: :btree

  create_table "interaccion_campanna_socials", force: :cascade do |t|
    t.string   "social_id",                   limit: 255
    t.integer  "organizacion_red_socials_id", limit: 4
    t.integer  "interaccion_campanna_id",     limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "interaccion_campanna_socials", ["interaccion_campanna_id"], name: "index_interaccion_campanna_socials_on_interaccion_campanna_id", using: :btree

  create_table "interaccion_campanna_usuarios", force: :cascade do |t|
    t.string   "observacion",             limit: 255
    t.integer  "duracion",                limit: 4
    t.string   "email",                   limit: 255
    t.string   "telefono_movil",          limit: 255
    t.integer  "usuario_id",              limit: 4
    t.integer  "interaccion_campanna_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "interaccion_campanna_usuarios", ["interaccion_campanna_id"], name: "index_interaccion_campanna_usuarios_on_interaccion_campanna_id", using: :btree
  add_index "interaccion_campanna_usuarios", ["usuario_id"], name: "index_interaccion_campanna_usuarios_on_usuario_id", using: :btree

  create_table "interaccions", force: :cascade do |t|
    t.string   "contenido",        limit: 255
    t.integer  "tipo_interaccion", limit: 4
    t.integer  "usuario_id",       limit: 4
    t.integer  "producto_id",      limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "interaccions", ["producto_id"], name: "index_interaccions_on_producto_id", using: :btree
  add_index "interaccions", ["usuario_id"], name: "index_interaccions_on_usuario_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "tipo_menu",  limit: 4, default: 0
    t.integer  "rol_id",     limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "menus", ["rol_id"], name: "index_menus_on_rol_id", using: :btree

  create_table "modo_pagos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "estatus",    limit: 1,   default: "A"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "nota", force: :cascade do |t|
    t.string   "titulo",     limit: 255
    t.text     "contenido",  limit: 65535
    t.string   "color",      limit: 255
    t.integer  "usuario_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "nota", ["usuario_id"], name: "index_nota_on_usuario_id", using: :btree

  create_table "opcion_menus", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.boolean  "raiz",       limit: 1
    t.string   "url",        limit: 255
    t.integer  "padre_id",   limit: 4
    t.integer  "menu_id",    limit: 4
    t.string   "icono",      limit: 255
    t.integer  "orden",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "opcion_menus", ["menu_id"], name: "index_opcion_menus_on_menu_id", using: :btree
  add_index "opcion_menus", ["padre_id"], name: "index_opcion_menus_on_padre_id", using: :btree

  create_table "organizacion_red_socials", force: :cascade do |t|
    t.string   "url",              limit: 255
    t.integer  "red_social_id",    limit: 4
    t.integer  "organizacion_id",  limit: 4
    t.string   "uid",              limit: 255
    t.string   "provider",         limit: 255
    t.string   "oauth_token",      limit: 255
    t.string   "oauth_secret",     limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "organizacion_red_socials", ["organizacion_id"], name: "index_organizacion_red_socials_on_organizacion_id", using: :btree
  add_index "organizacion_red_socials", ["red_social_id"], name: "index_organizacion_red_socials_on_red_social_id", using: :btree

  create_table "organizacions", force: :cascade do |t|
    t.string   "nombre",               limit: 255
    t.string   "subdominio",           limit: 255
    t.string   "direccion",            limit: 255
    t.text     "descripcion",          limit: 4294967295
    t.string   "slogan",               limit: 255
    t.text     "mision",               limit: 65535
    t.text     "vision",               limit: 65535
    t.string   "telefono",             limit: 255
    t.string   "email",                limit: 255
    t.binary   "logo",                 limit: 4294967295
    t.string   "formato_logo",         limit: 255
    t.binary   "banner",               limit: 4294967295
    t.string   "formato_banner",       limit: 255
    t.text     "iframe",               limit: 4294967295
    t.string   "titulo_banner",        limit: 255
    t.string   "subtitulo_banner",     limit: 255
    t.string   "estatus",              limit: 1,          default: "A"
    t.integer  "pais_id",              limit: 4
    t.integer  "usuario_id",           limit: 4
    t.integer  "tipo_organizacion_id", limit: 4
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "organizacions", ["pais_id"], name: "index_organizacions_on_pais_id", using: :btree
  add_index "organizacions", ["tipo_organizacion_id"], name: "index_organizacions_on_tipo_organizacion_id", using: :btree
  add_index "organizacions", ["usuario_id"], name: "index_organizacions_on_usuario_id", using: :btree

  create_table "pago_contratos", force: :cascade do |t|
    t.float    "monto",        limit: 24
    t.datetime "fecha",                   null: false
    t.integer  "usuario_id",   limit: 4
    t.integer  "contrato_id",  limit: 4
    t.integer  "modo_pago_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "pago_contratos", ["contrato_id"], name: "index_pago_contratos_on_contrato_id", using: :btree
  add_index "pago_contratos", ["modo_pago_id"], name: "index_pago_contratos_on_modo_pago_id", using: :btree
  add_index "pago_contratos", ["usuario_id"], name: "index_pago_contratos_on_usuario_id", using: :btree

  create_table "pais", force: :cascade do |t|
    t.string   "iso",             limit: 3,   default: "A"
    t.string   "nombre",          limit: 255
    t.string   "nicename",        limit: 255
    t.string   "iso3",            limit: 3,   default: "A"
    t.string   "numcode",         limit: 3,   default: "A"
    t.integer  "codigo_telefono", limit: 8,                 null: false
    t.string   "estatus",         limit: 1,   default: "A"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "perfils", force: :cascade do |t|
    t.string   "nombres",            limit: 255
    t.string   "apellidos",          limit: 255
    t.string   "sexo",               limit: 255
    t.string   "ocupacion",          limit: 255
    t.date     "fecha_nacimiento"
    t.string   "telefono_movil",     limit: 11
    t.boolean  "confirmacion_movil", limit: 1,          default: false, null: false
    t.integer  "authy_id",           limit: 4
    t.integer  "usuario_id",         limit: 4
    t.binary   "foto",               limit: 4294967295
    t.string   "formato_foto",       limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "perfils", ["authy_id"], name: "index_perfils_on_authy_id", using: :btree
  add_index "perfils", ["usuario_id"], name: "index_perfils_on_usuario_id", using: :btree

  create_table "plan_servicios", force: :cascade do |t|
    t.string   "descripcion", limit: 255
    t.integer  "plan_id",     limit: 4
    t.integer  "servicio_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "plan_servicios", ["plan_id"], name: "index_plan_servicios_on_plan_id", using: :btree
  add_index "plan_servicios", ["servicio_id"], name: "index_plan_servicios_on_servicio_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "nombre",             limit: 255
    t.text     "descripcion",        limit: 65535
    t.float    "costo",              limit: 24
    t.binary   "imagen",             limit: 4294967295
    t.string   "formato_imagen",     limit: 255
    t.string   "estatus",            limit: 1,          default: "A"
    t.integer  "frecuencia_pago_id", limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "plans", ["frecuencia_pago_id"], name: "index_plans_on_frecuencia_pago_id", using: :btree

  create_table "pregunta_frecuentes", force: :cascade do |t|
    t.string   "pregunta",        limit: 255
    t.string   "respuesta",       limit: 255
    t.integer  "organizacion_id", limit: 4
    t.string   "estatus",         limit: 1,   default: "A"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre",         limit: 255
    t.text     "descripcion",    limit: 65535
    t.float    "precio",         limit: 24
    t.binary   "imagen",         limit: 4294967295
    t.string   "formato_imagen", limit: 255
    t.integer  "categoria_id",   limit: 4
    t.string   "estatus",        limit: 1,          default: "A"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "productos", ["categoria_id"], name: "index_productos_on_categoria_id", using: :btree

  create_table "publicidads", force: :cascade do |t|
    t.date     "fecha_inicio"
    t.date     "fecha_finalizacion"
    t.string   "estatus",            limit: 1,          default: "A"
    t.binary   "imagen",             limit: 4294967295
    t.string   "formato_imagen",     limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "red_socials", force: :cascade do |t|
    t.string   "icono",      limit: 255
    t.string   "nombre",     limit: 255
    t.string   "color",      limit: 255
    t.boolean  "difusion",   limit: 1,   default: false
    t.string   "estatus",    limit: 1,   default: "A"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "rols", force: :cascade do |t|
    t.string   "nombre",               limit: 255
    t.boolean  "acceso_administrable", limit: 1,   default: false, null: false
    t.string   "estatus",              limit: 1,   default: "A"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "servicios", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.string   "icono",       limit: 255
    t.string   "estatus",     limit: 1,   default: "A"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "sugerencia", force: :cascade do |t|
    t.string   "titulo",     limit: 255
    t.string   "contenido",  limit: 255
    t.integer  "usuario_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sugerencia", ["usuario_id"], name: "index_sugerencia_on_usuario_id", using: :btree

  create_table "temas", force: :cascade do |t|
    t.string   "nombre",         limit: 255
    t.string   "descripcion",    limit: 255
    t.binary   "imagen",         limit: 4294967295
    t.string   "formato_imagen", limit: 255
    t.string   "estatus",        limit: 1,          default: "A"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "tipo_clientes", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.string   "estatus",     limit: 1,   default: "A"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "tipo_organizacions", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "descripcion", limit: 255
    t.string   "estatus",     limit: 1,   default: "A"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "usuario_red_socials", force: :cascade do |t|
    t.string   "url",              limit: 255
    t.integer  "red_social_id",    limit: 4
    t.integer  "usuario_id",       limit: 4
    t.string   "uid",              limit: 255
    t.string   "provider",         limit: 255
    t.string   "oauth_token",      limit: 255
    t.string   "oauth_secret",     limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "usuario_red_socials", ["red_social_id"], name: "index_usuario_red_socials_on_red_social_id", using: :btree
  add_index "usuario_red_socials", ["usuario_id"], name: "index_usuario_red_socials_on_usuario_id", using: :btree

  create_table "usuario_rols", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "rol_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "usuario_rols", ["rol_id"], name: "index_usuario_rols_on_rol_id", using: :btree
  add_index "usuario_rols", ["usuario_id"], name: "index_usuario_rols_on_usuario_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "username",               limit: 255, default: "",    null: false
    t.boolean  "confirmacion_email",     limit: 1,   default: false, null: false
    t.integer  "pais_id",                limit: 4
    t.integer  "tipo_cliente_id",        limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.integer  "current_rol_id",         limit: 4
    t.boolean  "current_administrable",  limit: 1,   default: false, null: false
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "usuarios", ["current_rol_id"], name: "index_usuarios_on_current_rol_id", using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["pais_id"], name: "index_usuarios_on_pais_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["tipo_cliente_id"], name: "index_usuarios_on_tipo_cliente_id", using: :btree

  create_table "variable_categoria", force: :cascade do |t|
    t.integer  "categoria_id",             limit: 4
    t.integer  "variable_psicografica_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "variable_categoria", ["categoria_id"], name: "index_variable_categoria_on_categoria_id", using: :btree
  add_index "variable_categoria", ["variable_psicografica_id"], name: "index_variable_categoria_on_variable_psicografica_id", using: :btree

  create_table "variable_psicograficas", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.text     "descripcion", limit: 65535
    t.string   "estatus",     limit: 1,     default: "A"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "variable_usuarios", force: :cascade do |t|
    t.integer  "variable_psicografica_id", limit: 4
    t.integer  "usuario_id",               limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "variable_usuarios", ["usuario_id"], name: "index_variable_usuarios_on_usuario_id", using: :btree
  add_index "variable_usuarios", ["variable_psicografica_id"], name: "index_variable_usuarios_on_variable_psicografica_id", using: :btree

  add_foreign_key "autenticacions", "usuarios"
end
