require 'rbnacl'
class ArmoredCar
  def directify
    puts "Specify a working directory where keys and verification tags will be saved:"
    @directory = gets.chomp!
  end

  def loader(file)
    #grabs a keyfile from the user
    puts "Where is your keyfile?"
    keyfile = File.open(gets.chomp!)
    key = File.read(keyfile)
    keyfile.close

    #instantiates secret box named car
    car = RbNaCl::SecretBox.new(key)
   
    
    #creates a one time value based on the new secret box
    nonce = RbNaCl::Random.random_bytes(car.nonce_bytes)
    
    #reads message to encrypt
    targetfile = File.open(file)
    target = File.read(targetfile)
    targetfile.close
    
    #encrypts file
    ciphertext = car.encrypt(nonce,target)
    
    #creates encrypted file
    cipherfile = File.new("#{@directory}untitledenc.txt", "w+")
    cipherfile.write(ciphertext)
    cipherfile.close 
    #creates nonce file for user to use in decryption
    noncefile = File.new("#{@directory}verificationtag", "w+")
    noncefile.write(nonce)
    noncefile.close 
  end
  
  def unloader(file)
    #open / decrypt file
    puts "Where is your keyfile?"
    keyfile = File.open(gets.chomp!)
    key = File.read(keyfile)
    keyfile.close
    
    #instantiates secret box named car/
    car = RbNaCl::SecretBox.new(key)

    #asks for verificationtag(nonce) from user
    puts "Where is your verification tag?"
    noncefile = File.open(gets.chomp!)
    nonce = File.read(noncefile)
    noncefile.close

    #Read the ciphertext from given file
    targetfile = File.open(file)
    target = File.read(targetfile)
    targetfile.close

    #Decrypts File
    message = car.decrypt(nonce,target)
    File.new("#{@directory}untitleddecoded.txt", "w+").write(message)
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