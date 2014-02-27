class ArmoredCar
  def target
    puts "Give me a file..."
    @package = gets.chomp!
    system "openssl enc -aes-256-cbc -salt -in", @package, "-out file.txt.enc"
    #Decryption
    #openssl enc aes-256-cbc -d -in file.txt.enc -out file.txt
  end
  
  def dispatch
  end
end

x = ArmoredCar.new()
x.target