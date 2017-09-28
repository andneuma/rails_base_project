# USERS
User.destroy_all
User.create(
				name: 'test',
				email: 'user@test.com',
				password: 'secret',
				password_confirmation: 'secret',
				activated: true,
				is_admin: false
)

User.create(
				name: 'admin',
				email: 'admin@test.com',
				password: 'secret',
				password_confirmation: 'secret',
				activated: true,
				is_admin: true
)
