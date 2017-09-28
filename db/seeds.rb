# USERS
User.destroy_all
u1 = User.create(
				name: 'test',
				email: 'user@test.com',
				password: 'secret',
				password_confirmation: 'secret',
				activated: true,
				is_admin: false
)

u1.activation_tokens.first.update_attributes(redeemed: true)

User.create(
				name: 'admin',
				email: 'admin@test.com',
				password: 'secret',
				password_confirmation: 'secret',
				activated: true,
				is_admin: true
)
