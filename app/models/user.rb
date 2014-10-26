class User < ActiveRecord::Base
	
	has_many :campaigns
	has_many :donations

	before_save { self.mail = mail.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	attr_accessible :firstname, :lastname, :mail, :password, :password_confirmation, :money

	validates :mail, presence:   true,
	                format:     { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }

	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :mail
	validates_uniqueness_of :mail

	def self.authenticate(mail, password)
		user = find_by_mail(mail)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	# get name of owner
	def self.campaign_owner_name(campaign)
		users = User.all
		owner = users.find(campaign.user_id)
		[owner.firstname, owner.lastname].join(' ')
	end

	# get name of owner
	def self.donation_owner_name(donation)
		users = User.all
		owner = users.find(donation.user_id)
		[owner.firstname, owner.lastname].join(' ')
	end

	def self.number_of_campaigns(user)
		user.campaigns.count
	end

	def self.number_of_donations_for_user(user)
		user.donations.group(:campaign_id).count.count
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
