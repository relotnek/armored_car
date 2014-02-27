require 'rbnacl'

class ArmoredCar
  def loader(file)
    #grabs a key from the user, for now generates random key
    puts "We're carving out a key for you:"
    puts "Here's your key:"
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    
    puts "Keep this key safe, this is how you'll open the armored car."
    
    #instantiates secret box named car
    car = RbNaCl::SecretBox.new(key)
    
    #creates a one time value based on the new secret box
    nonce = RbNaCl::Random.random_bytes(car.nonce_bytes)
    
    #reads message to encrypt
    target = File.open(file).read
    
    #encrypts
    ciphertext = car.encrypt(nonce,target)
    
    File.new("/Users/kentoler/Development/Ruby/armored_car/tests/untitledenc.txt", "w+").write(ciphertext)
    puts File.read("/Users/kentoler/Development/Ruby/armored_car/tests/untitledenc.txt")
  end
  
  def unloader(file)
    #open / decrypt file
    puts "Key please..."
    key = gets.chomp
    
    #instantiates secret box named car
    car = RbNaCl::SecretBox.new(key)
    
    #creates a one time value based on the new secret box
    nonce = RbNaCl::Random.random_bytes(car.nonce_bytes)
    
    ciphertext = File.open(file).read
    puts car.decrypt(nonce,ciphertext)
    
  end
  
  def transport
    #send file
  end
  
end


x = ArmoredCar.new()
puts "Specify the absolute location of your file:"
x.loader(gets.chomp!)

puts "Specify the absolute locaton of the encrypted file:"
x.unloader(gets.chomp!)
