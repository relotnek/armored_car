class ArmoredCar
  def load(file)
    #grabs a key from the user
    puts "Choose a super secret password:"
    key = gets.chomp!
    
    #instantiates secret box named car
    car = RbNaCl::SecretBox.new(key)
    
    #creates a one time value based on the new secret box
    nonce = RbNaCl::Random.random_bytes(car.nonce_bytes)
    
    #reads message to encrypt
    target = File.open(file).read
    
    #encrypts
    ciphertext = car.encrypt(nonce,target)
    
    puts ciphertext
  end
  
  def unload(file)
  end
  
  def transport
  end
  
end


x = ArmoredCar.new()

x.load(gets.chomp!)


