library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector_dut: in std_logic_vector(1 downto 0));
end entity;

architecture processor_instance of DUT is 


component  datapath is

   port(
		input_vector: in std_logic_vector(1 downto 0));
		
end component ;
	
begin

processor : datapath 
			port map  (
		input_vector =>  input_vector_dut);
	

end processor_instance;