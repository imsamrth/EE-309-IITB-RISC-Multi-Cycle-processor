library ieee;
use ieee.std_logic_1164.all;

entity inst_register is
	port ( i : IN STD_LOGIC_VECTOR(15 downto 0);
			inst_read : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;
				ir_11_9 : OUT STD_LOGIC_VECTOR(2 downto 0);
				ir_8_6 : OUT STD_LOGIC_VECTOR(2 downto 0);
				ir_5_0 : OUT STD_LOGIC_VECTOR(5 downto 0);
				ir_8_0 : OUT STD_LOGIC_VECTOR(8 downto 0);
				ir_5_3 : OUT STD_LOGIC_VECTOR(2 downto 0));
end inst_register ;


architecture arch of inst_register is
		begin
			process (clk, clr)
			begin
				if clr = '1' then
					ir_5_0 <= "000000";
				elsif rising_edge(clk) then
					if inst_read = '1' then
						ir_11_9 <= i(11 downto 9);
						ir_11_9 <= i(2 downto 0);
				ir_8_6 <= i(2 downto 0);
				ir_5_0 <= i(5 downto 0);
				ir_8_0 <= i(8 downto 0);
				ir_5_3 <= i(2 downto 0);
					end if;
					end if;
			end process;
end arch ;