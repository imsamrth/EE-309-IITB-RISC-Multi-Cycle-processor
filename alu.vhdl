 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.add.all;

entity alu is
port(
  alu_A, alu_B: in std_logic_vector(15 downto 0);
  output: out std_logic_vector(15 downto 0);
  cin: in std_logic;
  sel : in std_logic_vector (1 downto 0);
  CY, Z: out std_logic);
end entity alu;

architecture behave of alu is
  signal output_temp: std_logic_vector(15 downto 0);
  signal output_add: std_logic_vector(15 downto 0);
  signal C: std_logic_vector(16 downto 1);
begin
  
  ADD0: adder
    port map(
      A => alu_A, B => alu_B,
      cin => cin, S => output_add, Cout => C);
      
  CY <= C(16);
  
  process(alu_A,alu_B,sel,output_add)
  begin
    if (sel = "01") then
      output_temp <= output_add;
		
		
		if (to_integer(unsigned(output_temp)) = 0) then 
		
		
		  Z <= '1' ;
		  
		  else 
		   Z <='0';
		  
		  end if ;
		  
		  
    elsif (sel = "11") then 
      output_temp <= alu_A nand alu_B;
		
	if (to_integer(unsigned(output_temp)) = 0) then 
		
		
		  Z <= '1' ;
		  
		  else 
		   Z <= '0';
		  
		  end if ;
	
	elsif (sel = "10") then 
	
	if (alu_A = alu_B) then 
	 z <= '1' ;
	 
	 else 
	 
	 z <= '0' ;
	 
		
    end if;
	 
	 else 
	 
		if (to_integer(unsigned(output_temp)) = 0) then 
		
		
		  Z <= '1' ;
		  
		  else 
		   Z <= '0';
		  
		  end if ;
	 
	 end if;
	 
	 
	 
	 
	 
  end process;
  

  output <= output_temp;

    
end architecture;