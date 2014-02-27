require 'rbnacl'
class ArmoredCar
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
    File.new("/home/ktoler/Desktop/untitledenc.txt", "w+").write(ciphertext)
    #creates nonce file for user to use in decryption
    File.new("/home/ktoler/Desktop/verificationtag", "w+").write(nonce)  
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
    message = car.decrypt(File.read("/home/ktoler/Desktop/verificationtag"),target)

    File.new("/home/ktoler/Desktop/untitleddecoded.txt", "w+").write(ciphertext)
  end
  
  def transport
    #send file
  end

  def generate
    puts "To generate a keyfile, give me the path you would like to use:"
    keyfilepath = gets.chomp
    keyfile = File.new("/home/ktoler/Desktop/keyfile", "w+")
    File.write(keyfile,RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes))
  end
  
end


x = ArmoredCar.new()
puts "GENERATING"
x.generate

puts "LOADING"
x.loader("/home/ktoler/Desktop/untitled.txt")

puts "DECRYPTING"
x.unloader("/home/ktoler/Desktop/untitledenc.txt")