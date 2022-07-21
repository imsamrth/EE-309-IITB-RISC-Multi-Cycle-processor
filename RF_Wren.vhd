library ieee;
use ieee.std_logic_1164.all;

entity Regfile_wren is
	port (RF : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        R0_en, R1_en, R2_en, R3_en, R4_en, R5_en, R6_en, R7_en : OUT STD_LOGIC
        );
end Regfile_wren;


architecture description of Regfile_wren is
  constant S4: STD_LOGIC_VECTOR(4 downto 0)  :=  "00100";
  constant S6: STD_LOGIC_VECTOR(4 downto 0)  :=  "00110";
  constant S7: STD_LOGIC_VECTOR(4 downto 0)  :=  "00111";
  constant S9: STD_LOGIC_VECTOR(4 downto 0)  :=  "01100";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) :=  "01110";
  constant S16: STD_LOGIC_VECTOR(4 downto 0) :=  "10000";
  constant S17: STD_LOGIC_VECTOR(4 downto 0) :=  "10001";

		begin
			process (RF, current_state)
			begin
				if (current_state = S4) or (current_state = S6) or (current_state = S7) or (current_state = S9) or (current_state = S14) or (current_state = S16) or (current_state = S17) then
					case Rf is
						when "000" =>
		               R0_en <= '1'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
						when "001" =>
	          	      R0_en <= '0'; R1_en <= '1'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
						when "010" =>
	                  R0_en <= '0'; R1_en <= '0'; R2_en <= '1'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
						when "011" =>
	                  R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '1'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
						when "100" =>
	                  R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '1'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
						when "101" =>
	                  R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '1'; R6_en <= '0'; R7_en <= '0';
						when "110" =>
	                  R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '1'; R7_en <= '0';
						
						when others =>
										R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
		      	end case;
				else
					R0_en <= '0'; R1_en <= '0'; R2_en <= '0'; R3_en <= '0'; R4_en <= '0'; R5_en <= '0'; R6_en <= '0'; R7_en <= '0';
			end if;

			end process;
end description;