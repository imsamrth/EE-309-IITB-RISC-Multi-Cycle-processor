library ieee;
use ieee.std_logic_1164.all;

entity lsi is
	port ( 
				lsi_input : IN STD_LOGIC_VECTOR(15 downto 0);
				lsi_output : OUT STD_LOGIC_VECTOR(15 downto 0));
end lsi ;


architecture arch of lsi is

begin 

lsi_output(15 downto 1) <= lsi_input(14 downto 0);
lsi_output(0) <= lsi_input(15);
end arch ;