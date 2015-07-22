# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Daytype.create ([{name: "workdays"}, {name: "holidays"}])
QuestStatus.create ([{name: "Включен"}, {name: "Выключен"}])
TicketStatus.create ([{name: "Свободен"}, {name: "Зарезервирован"}, {name: "Выкуплен"}, {name: "Снят с продажи"}])
QuestItem.create ([{name: "Люди Экс"}])
PricePreset.create([{quest_item_id: 1, daytype_id: 1, t0: '00:00:00', t1: '02:30:00', price: 3500},
                    {quest_item_id: 1, daytype_id: 1, t0: '02:31:00', t1: '16:30:00', price: 2500},
                    {quest_item_id: 1, daytype_id: 1, t0: '16:31:00', t1: '23:59:00', price: 3500},
                    {quest_item_id: 1, daytype_id: 2, t0: '00:00:00', t1: '02:30:00', price: 4500},
                    {quest_item_id: 1, daytype_id: 2, t0: '02:31:00', t1: '06:30:00', price: 2500},
                    {quest_item_id: 1, daytype_id: 2, t0: '06:31:00', t1: '23:59:00', price: 4500}])