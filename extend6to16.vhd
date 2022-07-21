library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity convert6to16bit is
	port (input : IN STD_LOGIC_VECTOR(5 downto 0);

				output : OUT STD_LOGIC_VECTOR(15 downto 0));
end convert6to16bit ;


architecture arch of convert6to16bit is
		begin
			process (input)
			begin
				output <= std_logic_vector(resize(signed(input), 16));
			end process;
end arch ;