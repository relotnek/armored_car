require 'rbnacl'
class ArmoredCar
  def loader(file)
    #grabs a key from the user
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    
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
    
  end
  
  def transport
  end
  
end


x = ArmoredCar.new()
x.loader("/Users/kentoler/Development/Ruby/armored_car/tests/untitled.txt")

