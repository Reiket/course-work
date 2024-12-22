names = %w[Віктор Олег Максим Ольга Антоніна Катерина Вікторія Марія Артем Халіма]
surnames = %w[Ревшенко Пеньковський Перетягін Марків Семенюк Підгайна Шимончак Самборська Шевчук Чижик]
phone_numbers = %w[380966534632 380965353564 380965345367 380966420632 380966420632 380966420632 380966420632
                  380966420632 380966420632 380966420632]
positions = %w[Лікар-рентгенолог Лікар-стоматолог Лікар-токсиколог Лікар-терапевт Лікар-хірург Лікар-психолог
               Лікар-нарколог Лікар-кардіолог Лікар-вірусолог Лікар-офтальмолог]
days_of_week = %w[Понеділок Вівторок Середа Четвер П'ятниця Субота Неділя]
hours_of_day = %w[10:00:00 12:00:00 13:00:00 14:00:00 17:00:00 18:00:00 11:00:00 09:00:00]

DAYS_HASH = {
  'Понеділок' => 1,
  'Вівторок' => 2,
  'Середа' => 3,
  'Четвер' => 4,
  "П'ятниця" => 5,
  'Субота' => 6,
  'Неділя' => 7
}

(1..10).each do |index|
  simple_user = User.create!(
    email:    "doctor#{index}@gmail.com",
    password: "doctor#{index}@gmail.com",
    role:     "doctor"
  )

  doctor = Doctor.create(
    name: names[index - 1],
    surname: surnames[index - 1],
    photo: File.open("app/assets/images/doctors/doctor-#{index}.png"),
    phone_number: phone_numbers[index - 1],
    position: positions[index - 1],
    experience: rand(2..10),
    user_id: simple_user.id
  )

  schedule = Schedule.create(
    status: 'active',
    doctor_id: doctor.id
  )

  (1..7).each do |i|
    day = WorkingDay.create(
      name: days_of_week[i - 1],
      status: 'workday',
      priority: i,
      schedule_id: schedule.id
    )

    rand(1..8).times do
      current_date = DateTime.now - DateTime.now.wday + DAYS_HASH[day.name]
      hour = DateTime.parse("#{current_date.strftime('%Y-%m-%d')} #{hours_of_day.sample} #{Time.zone}")

      WorkingHour.create(
        hour: hour,
        status: 'free',
        working_day_id: day.id
      )
    end
  end
end

names = %w[Іван Тарас Артур Максим Вікторія Марта Леся Тетяна Станіслав Настя]
surnames = %w[Пріре Вененко Салін Перето Самандів Наконечна Боруцька Фридер Санта Вершів]
cities = %w[Львів Київ Тернопіль Херсон Миколаїв Одеса Ужгород Луцьк Хмельницьк Полтава]
gender = %w[male male male male female female female female male female]

(1..10).each do |index|
  simple_user = User.create!(
    email:    "patient#{index}@gmail.com",
    password: "patient#{index}@gmail.com",
    role:     "patient"
  )

  patient = Patient.create(
    name: names[index - 1],
    surname: surnames[index - 1],
    photo: File.open("app/assets/images/patients/patient-#{index}.png"),
    phone_number: phone_numbers[index - 1],
    residence: cities[index - 1],
    gender: gender[index - 1],
    birthday: Time.now - 20.years,
    user_id: simple_user.id
  )
end

(1..10).each do |index|
  (1..10).each do |i|
    Rating.create(
      score: rand(1..5),
      review: 'Ну просто відгук',
      patient_id: index,
      doctor_id: i
    )
  end
end
