library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtended9 is
	port (input : IN STD_LOGIC_VECTOR(8 downto 0);

				output : OUT STD_LOGIC_VECTOR(15 downto 0));
end SignExtended9;


architecture extender of SignExtended9 is
		begin
			process (input)
			begin
        output <= std_logic_vector(resize(signed(input), 16));
			end process;
end extender;