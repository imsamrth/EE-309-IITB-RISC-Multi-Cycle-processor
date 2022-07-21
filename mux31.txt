library ieee;
use ieee.std_logic_1164.all;

entity mux3into1 is
port(two,one,zero:in std_logic_vector(15 downto 0);
     output:out std_logic_vector(15 downto 0); 
     sel:in std_logic_vector(1 downto 0));
end entity;

architecture d_mux3into1 of mux3into1 is


begin
	
process(zero,one,sel,two)
variable muxvar: std_logic_vector(15 downto 0); 
begin

case sel is 
	when "00" =>
        muxvar:=zero;
    when "01" =>
        muxvar:=one;
    when "10" =>
        muxvar:=two;
    when others =>
        muxvar:="XXXXXXXXXXXXXXXX";
end case;

output<= muxvar;

end process;

end;