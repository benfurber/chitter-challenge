def empty_databases
  @connection.exec('
    TRUNCATE users;
    TRUNCATE peeps;
  ')
end

def add_test_users_directly(user_details)
  user_details.map do |user|
    @connection.exec("
      INSERT INTO users(id, email, user_name, password) VALUES(
      DEFAULT, '#{user[:email]}', '#{user[:user_name]}', '#{user[:password]}');
    ")
  end
end

def add_test_users(user_details)
  @test_users = user_details.map do |user|
    User.create(:email => user[:email], :user_name => user[:user_name], :password => user[:password])
  end
end

def add_test_peeps_directly(peep_details)
  peep_details.map do |peep|
    @connection.exec("
      INSERT INTO peeps(id, message, created_at, user_id) VALUES(
      DEFAULT, '#{peep[:message]}', '#{peep[:created_at]}', '#{peep[:user_id]}');
    ")
  end
end

def add_test_peeps(test_user_id)
  test_peep_1 = Peep.create(
    :message => "Some test words",
    :created_at => '2018-05-12 18:17:23 +0100',
    :user_id => test_user_id
  )
  test_peep_2 = Peep.create(
    :message => "More test words",
    :created_at => '2018-05-12 18:17:25 +0100',
    :user_id => test_user_id
  )
  test_peep_3 = Peep.create(
    :message => "MORE TESTING!?!?!",
    :created_at => '2018-05-12 18:18:24 +0100',
    :user_id => test_user_id
  )
  @test_peeps = [test_peep_1, test_peep_2, test_peep_3]
end

def log_in_form(user_name, user_password)
  fill_in 'user_name_field', with: user_name
  fill_in 'password_field', with: user_password
  click_button 'login_button'
end

def full_log_in_journey(user_name, user_password)
  visit '/session/login'
  log_in_form(user_name, user_password)
end
