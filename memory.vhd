library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is 
	port(
		
		address  : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(15 DOWNTO 0);
		data_IN   : in std_logic_vector(15 DOWNTO 0);
		wrt  : in std_logic;
		rst : in std_logic; 
		clk : in std_logic); 
	
	end memory;

architecture arch of memory is 


			type register_array is array(0 to 65535 ) of std_logic_vector(15 downto 0);
			signal kb_memory : register_array ;

begin

data_fetch: process(rst, clk)

begin
			
if rising_edge (clk) then
				
				if wrt ='0' then
					data_out <=	kb_memory(to_integer(unsigned(address)))  ;
				else 
					kb_memory(to_integer(unsigned(address))) <= data_in;
				
				end if;
				
			end if;	
					
	end process data_fetch;

end arch;