require 'rbnacl'
class ArmoredCar
  def directify
    puts "What's our directory?"
    @directory = gets.chomp
  end

  def loader(file)
    #grabs a keyfile from the user
    puts "Where is your keyfile?"
    keyfile = gets.chomp

    #instantiates secret box named car
    car = RbNaCl::SecretBox.new(File.read(keyfile))
    
    #creates a one time value based on the new secret box
    nonce = RbNaCl::Random.random_bytes(car.nonce_bytes)
    
    #reads message to encrypt
    target = File.open(file).read
    
    #encrypts file
    ciphertext = car.encrypt(nonce,target)
    
    #creates encrypted file
    File.new("#{@directory}untitledenc.txt", "w+").write(ciphertext)
    #creates nonce file for user to use in decryption
    File.new("#{@directory}verificationtag", "w+").write(nonce)  
  end
  
  def unloader(file)
    #open / decrypt file
    puts "Where is your keyfile?"
    keyfile = gets.chomp

    #asks for verificationtag(nonce) from user
    puts "Where is your verification tag?"
    noncefile = gets.chomp
    
    #instantiates secret box named car/
    car = RbNaCl::SecretBox.new(File.read(keyfile))


    #Read the ciphertext from given file
    target = File.open(file).read

    #Decrypts File
    message = car.decrypt(File.read("#{@directory}verificationtag"),target)

    File.new("#{@directory}untitleddecoded.txt", "w+").write(ciphertext)
  end
  
  def transport
    #send file
  end

  def generate
    puts "Generating keyfile in specified directory #{@directory}:"
    keyfile = File.new("#{@directory}keyfile", "w+")
    File.write(keyfile,RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes))
  end
  
end


x = ArmoredCar.new()

x.directify

puts "GENERATING"
x.generate

puts "LOAD: Give the absolute path of your file:"
x.loader(gets.chomp)

puts "DECRYPT: Give the absolute path of your encrypted file:"
x.unloader(gets.chomp)