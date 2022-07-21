library ieee;
use ieee.std_logic_1164.all;
	USE ieee.numeric_std.ALL;

entity register_set is
	port (a_1 : IN STD_LOGIC_VECTOR(2 downto 0);
	a_2 : IN STD_LOGIC_VECTOR(2 downto 0);
	a_3 : IN STD_LOGIC_VECTOR(2 downto 0);
	d_3 : IN STD_LOGIC_VECTOR(15 downto 0);
	d_1 : out STD_LOGIC_VECTOR(15 downto 0);
	d_2 : out STD_LOGIC_VECTOR(15 downto 0);
	
	clk : in std_logic ;
	rst : in std_logic ;
	
	rf_control_bit : IN STD_LOGIC_VECTOR(2 downto 0));
end register_set ;


architecture arch of register_set is 
 
component register_16bit is
	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
				wrt : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;
				q : OUT STD_LOGIC_VECTOR(15 downto 0));
end component ;

signal signal_a1 : std_logic_vector(15 downto 0 );
signal signal_a3 : std_logic_vector(15 downto 0 );
signal signal_a2 : std_logic_vector(15 downto 0 );

signal data_1 : std_logic_vector(15 downto 0 );
signal data_2 : std_logic_vector(15 downto 0 );
signal data_3 : std_logic_vector(15 downto 0 );
signal data_4 : std_logic_vector(15 downto 0 );
signal data_5 : std_logic_vector(15 downto 0 );
signal data_6 : std_logic_vector(15 downto 0 );
signal data_7 : std_logic_vector(15 downto 0 );
signal data_0 : std_logic_vector(15 downto 0 );
signal write_signal : std_logic; 
 
 

begin

register_0 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_0 );
register_1 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_1 );
			
register_2 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_2 );
				
register_3 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_3 );
				
				
register_4 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_4 );
				
				
				
register_5 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_5 );
				
				
register_6 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_6 );
				
				
				
register_7 : register_16bit 
	port map  (d => signal_a3,
				wrt => write_signal,
				clr => rst,
				clk => clk,
				q =>  data_7 );

				





			process ( clk, rst, a_1, a_2, a_3 , rf_control_bit )
			begin
			
			
			
			
			
			
			
			
			
if rst = '1' then
					d_1 <= "0000000000000000";
					d_2 <= "0000000000000000";
				elsif rising_edge(clk) then
					
						d_1 <= signal_a1 ;
						d_2 <= signal_a2 ;
						
					if ( unsigned(rf_control_bit) > 3 ) then 
					write_signal <= '1' ;
					if (unsigned(a_3) = 0) then 
					 data_0 <=  d_3 ; 
					elsif(unsigned(a_3) = 1 ) then
					data_1 <=  d_3 ;
				elsif(unsigned(a_3) = 2 ) then
			 data_2 <=  d_3 ;
				elsif(unsigned(a_3) = 3 ) then
	 data_3 <=  d_3 ;
				elsif(unsigned(a_3) = 4 ) then
		 data_4 <=  d_3 ;
				elsif(unsigned(a_3) = 5 ) then
				 data_5 <=  d_3 ;
				elsif(unsigned(a_3) = 6 ) then
					 data_6 <=  d_3 ;
				else
					 data_7 <=  d_3 ;
end if;

					
					end if;
					end if;

			end process;
end arch;