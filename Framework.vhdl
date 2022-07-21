library ieee;
use ieee.std_logic_1164.all;

entity framework is
    port (
  F0: in std_logic;
  F1: in std_logic;
  c : in std_logic;
  z : in std_logic;
  alu_inv: in std_logic;
  op_code : in std_logic_vector(3 downto 0);
  t : in std_logic_vector(4 downto 0);
  final_out : out std_logic_vector(1 downto 0));

  end framework;


architecture a1 of framework is

SIGNAL 	Y :  std_logic ;
SIGNAL 	u :  std_logic ;
SIGNAL 	s1 :  std_logic_vector(1 downto 0) ;
SIGNAL 	s2 :  std_logic_vector(1 downto 0) ;
SIGNAL 	s3 :  std_logic_vector(1 downto 0) ;
SIGNAL 	s4 :  std_logic_vector(1 downto 0) ; 
SIGNAL 	s5 :  std_logic_vector(1 downto 0);
			
begin
BITm : process(y)
begin

  Y <= ((F1 xnor F0) or (z and (not F1)) or (c and F1));
  u <= ((not t(4))and(not t(3))and(not t(2))and t(1) and t(0));

  if(Y = '1') then
    s1 <= "01";
    s2 <= "11";
  else
    s1 <= "00";
    s2 <= "00";
  end if;

  if(op_code(3) = '1') then
    s3 <= s1;
  else
    s3 <= s2;
  end if;

  if(op_code(0) = '1') then
    s4 <= "10" ;
  else
    s4 <= s3;
  end if;


  if(u = '1') then
    s5 <= s4;
  else
    s5 <= "01" ;
  end if;

  if(alu_inv = '1') then
   final_out <= s5;
  else
    final_out <= "00" ;
  end if; 

  end process;
end a1;