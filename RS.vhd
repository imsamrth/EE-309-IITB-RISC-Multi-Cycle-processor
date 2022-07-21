library ieee;
use ieee.std_logic_1164.all;

entity Regs_sel is
	port (Imm_reg : in STD_LOGIC_VECTOR(7 downto 0);

				Reg_num : OUT STD_LOGIC_VECTOR(2 downto 0);
        Num_Invalid : OUT STD_LOGIC);
end Regs_Sel;


architecture Registorselector of Regs_Sel is

  begin
    process (Imm_reg)
    begin
      if Imm_reg(0) = '1' then
        Reg_num <= "000";
		  
        Num_Invalid <= '0';
      elsif Imm_reg(1) = '1' then
        Reg_num <= "001";
        Num_Invalid <= '0';
      elsif Imm_reg(2) = '1' then
        Reg_num <= "010";
        Num_Invalid <= '0';
      elsif Imm_reg(3) = '1' then
        Reg_num <= "011";
        Num_Invalid <= '0';
      elsif Imm_reg(4) = '1' then
        Reg_num <= "100";
        Num_Invalid <= '0';
      elsif Imm_reg(5) = '1' then
        Reg_num <= "101";
        Num_Invalid <= '0';
      elsif Imm_reg(6) = '1' then
        Reg_num <= "110";
        Num_Invalid <= '0';
      elsif Imm_reg(7) = '1' then
        Reg_num <= "111";
        Num_Invalid <= '0';
      else
        Reg_num <= "000";
        Num_Invalid <= '1';
      end if;
    end process;
end Registorselector;